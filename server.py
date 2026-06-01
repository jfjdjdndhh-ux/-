from http.server import HTTPServer, BaseHTTPRequestHandler
import requests, base64, re, json, urllib.parse
from html import unescape
import concurrent.futures

INFINITY_BASE = "https://infinity-check.online/"
GROQ_KEY = "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"
DS_TOKEN = "WDTHx2vqZGE38gchBe7oAewzB9ZPNpxU"
DS_BASE = "https://api.depsearch.sbs/"
LEAKCHECK_URL = "https://leakcheck.io/api/public"

session = requests.Session()
HEADERS = {"X-Requested-With": "XMLHttpRequest"}

def parse_infinity(html):
    cards = []
    card_pattern = r'<div class="card result-card fade-in">(.*?)</div></div>'
    raw_cards = re.findall(card_pattern, html, re.DOTALL)
    for card_html in raw_cards:
        card = {}
        source_match = re.search(r'<div class="card-source">(.*?)</div>', card_html)
        if source_match:
            card['source'] = unescape(source_match.group(1))
        fields = re.findall(r'<strong>(.*?):</strong><span class="row-value">(.*?)</span>', card_html)
        for key, value in fields:
            card[key.strip()] = unescape(value).strip().replace('(at)', '@')
        if card:
            cards.append(card)
    return cards

def search_infinity(query):
    try:
        session.get(INFINITY_BASE)
        r = session.get(INFINITY_BASE, params={"action": "get_captcha"}, headers=HEADERS)
        img_b64 = r.json()["image"].split(",")[1]
        response = requests.post(
            "https://api.groq.com/openai/v1/chat/completions",
            headers={"Authorization": f"Bearer {GROQ_KEY}", "Content-Type": "application/json"},
            json={
                "model": "meta-llama/llama-4-scout-17b-16e-instruct",
                "max_tokens": 50,
                "messages": [{"role": "user", "content": [
                    {"type": "image_url", "image_url": {"url": f"data:image/png;base64,{img_b64}"}},
                    {"type": "text", "text": "Read CAPTCHA. Output ONLY characters, no spaces, exact case."}
                ]}]
            },
            timeout=10
        )
        captcha = response.json()["choices"][0]["message"]["content"].strip().replace(" ", "")
        result = session.post(INFINITY_BASE, data={"q": query, "captcha": captcha}, headers=HEADERS)
        cards = parse_infinity(result.json().get("html", ""))
        for card in cards:
            card['api_source'] = 'Infinity Check'
        return cards
    except Exception as e:
        print(f"Infinity error: {e}")
        return []

def search_depsearch(query):
    try:
        headers = {"Authorization": f"Bearer {DS_TOKEN}", "Content-Type": "application/json"}
        endpoints = [
            f"{DS_BASE}/search?q={urllib.parse.quote(query)}",
            f"{DS_BASE}/api/search?q={urllib.parse.quote(query)}",
            f"{DS_BASE}/v1/search?q={urllib.parse.quote(query)}",
        ]
        for url in endpoints:
            try:
                r = requests.get(url, headers=headers, timeout=10)
                if r.status_code == 200:
                    data = r.json()
                    results = data.get("results", data.get("data", []))
                    if isinstance(results, list):
                        for item in results:
                            if isinstance(item, dict):
                                item['api_source'] = 'DeepSearch'
                        return results
            except:
                continue
        r = requests.post(f"{DS_BASE}/search", headers=headers, json={"q": query}, timeout=10)
        if r.status_code == 200:
            data = r.json()
            results = data.get("results", data.get("data", []))
            for item in results:
                if isinstance(item, dict):
                    item['api_source'] = 'DeepSearch'
            return results
    except Exception as e:
        print(f"DeepSearch error: {e}")
    return []

def search_leakcheck(query):
    try:
        endpoints = [
            f"{LEAKCHECK_URL}/search?q={urllib.parse.quote(query)}",
            f"{LEAKCHECK_URL}?q={urllib.parse.quote(query)}",
            f"https://leakcheck.io/api?q={urllib.parse.quote(query)}",
        ]
        for url in endpoints:
            try:
                r = requests.get(url, timeout=10)
                if r.status_code == 200:
                    data = r.json()
                    results = data.get("results", data.get("data", []))
                    if isinstance(results, list):
                        for item in results:
                            if isinstance(item, dict):
                                item['api_source'] = 'LeakCheck'
                        return results
            except:
                continue
    except Exception as e:
        print(f"LeakCheck error: {e}")
    return []

def search_all(query):
    all_results = []
    with concurrent.futures.ThreadPoolExecutor(max_workers=3) as executor:
        futures = {
            executor.submit(search_infinity, query): "Infinity",
            executor.submit(search_depsearch, query): "DeepSearch",
            executor.submit(search_leakcheck, query): "LeakCheck",
        }
        for future in concurrent.futures.as_completed(futures):
            source = futures[future]
            try:
                results = future.result()
                all_results.extend(results)
                print(f"[+] {source}: {len(results)} results")
            except Exception as e:
                print(f"[-] {source}: {e}")
    return all_results

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/':
            self.send_response(200)
            self.send_header('Content-type', 'text/html; charset=utf-8')
            self.end_headers()
            self.wfile.write(HTML.encode())
        elif self.path == '/favicon.ico':
            self.send_response(204)
            self.end_headers()
        else:
            self.send_response(404)
            self.end_headers()

    def do_POST(self):
        if self.path == '/search':
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length)
            data = json.loads(post_data)
            query = data.get('query', '').strip()
            if not query:
                self.send_json({"success": False, "error": "Empty query"})
                return
            print(f"\n[*] Searching: {query}")
            results = search_all(query)
            print(f"[+] Total: {len(results)} results\n")
            self.send_json({"success": True, "results": results, "query": query})
        else:
            self.send_response(404)
            self.end_headers()

    def send_json(self, data):
        self.send_response(200)
        self.send_header('Content-type', 'application/json; charset=utf-8')
        self.end_headers()
        self.wfile.write(json.dumps(data, ensure_ascii=False).encode())

    def log_message(self, format, *args):
        pass

HTML = """<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OMEGA SEARCH</title>
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
body { background: #0a0a0a; font-family: 'Segoe UI', 'Arial', sans-serif; min-height: 100vh; color: #fff; }
canvas#bgCanvas { position: fixed; top: 0; left: 0; z-index: 0; }
.sidebar { position: fixed; left: 0; top: 0; width: 280px; height: 100vh; background: rgba(15,15,15,0.95); border-right: 1px solid #222; padding: 30px 20px; z-index: 10; backdrop-filter: blur(20px); display: flex; flex-direction: column; }
.profile { text-align: center; margin-bottom: 40px; }
.profile-avatar { width: 80px; height: 80px; border-radius: 50%; background: linear-gradient(135deg, #ff0000, #cc0000); display: flex; align-items: center; justify-content: center; font-size: 36px; margin: 0 auto 15px; box-shadow: 0 0 30px rgba(255,0,0,0.5); animation: avatarGlow 2s ease-in-out infinite; }
@keyframes avatarGlow { 0%, 100% { box-shadow: 0 0 30px rgba(255,0,0,0.5); } 50% { box-shadow: 0 0 60px rgba(255,0,0,0.8); } }
.profile-name { font-size: 20px; font-weight: bold; background: linear-gradient(90deg, #ff0000, #fff, #ff0000); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
.profile-status { font-size: 12px; color: #00ff00; margin-top: 5px; }
.profile-status::before { content: '● '; animation: statusBlink 1s infinite; }
@keyframes statusBlink { 0%, 100% { opacity: 1; } 50% { opacity: 0.3; } }
.stats { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-bottom: 30px; }
.stat-box { background: rgba(255,0,0,0.1); border: 1px solid #333; border-radius: 12px; padding: 15px; text-align: center; transition: all 0.3s; }
.stat-box:hover { border-color: #ff0000; box-shadow: 0 0 20px rgba(255,0,0,0.3); }
.stat-value { font-size: 24px; font-weight: bold; color: #ff0000; }
.stat-label { font-size: 11px; color: #888; margin-top: 5px; text-transform: uppercase; letter-spacing: 1px; }
.menu { flex: 1; }
.menu-item { display: flex; align-items: center; padding: 12px 15px; color: #888; text-decoration: none; border-radius: 10px; margin-bottom: 5px; transition: all 0.3s; cursor: pointer; font-size: 14px; }
.menu-item:hover, .menu-item.active { background: rgba(255,0,0,0.1); color: #fff; }
.menu-icon { margin-right: 12px; font-size: 18px; }
.main-content { margin-left: 280px; padding: 30px; position: relative; z-index: 1; }
.logo-section { text-align: center; margin-bottom: 40px; }
.logo-main { font-size: 64px; font-weight: 900; letter-spacing: 12px; background: linear-gradient(90deg, #ff0000, #ffffff, #ff0000, #ffffff, #ff0000); background-size: 300% 100%; -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; animation: shimmer 2s linear infinite; line-height: 1.2; }
@keyframes shimmer { 0% { background-position: 0% 50%; } 100% { background-position: 300% 50%; } }
.logo-sub { font-size: 14px; color: #666; letter-spacing: 8px; margin-top: 5px; }
.divider { width: 150px; height: 2px; margin: 15px auto; background: linear-gradient(90deg, transparent, #ff0000, #fff, #ff0000, transparent); animation: dividerPulse 2s infinite; }
@keyframes dividerPulse { 0%, 100% { opacity: 0.3; width: 150px; } 50% { opacity: 1; width: 250px; } }
.search-container { max-width: 700px; margin: 0 auto; }
.search-box { background: rgba(20,20,20,0.8); border: 1px solid #333; border-radius: 60px; padding: 8px; display: flex; align-items: center; backdrop-filter: blur(20px); transition: all 0.3s; }
.search-box:focus-within { border-color: #ff0000; box-shadow: 0 0 40px rgba(255,0,0,0.4); }
.search-input { flex: 1; background: none; border: none; color: #fff; font-size: 16px; padding: 15px 20px; outline: none; }
.search-input::placeholder { color: #555; }
.search-btn { background: linear-gradient(135deg, #ff0000, #cc0000); border: none; color: #fff; padding: 15px 35px; border-radius: 50px; font-size: 14px; font-weight: bold; cursor: pointer; transition: all 0.3s; letter-spacing: 2px; text-transform: uppercase; }
.search-btn:hover { transform: scale(1.05); box-shadow: 0 0 40px rgba(255,0,0,0.6); }
.search-btn:disabled { opacity: 0.5; cursor: not-allowed; transform: none; }
.api-indicators { display: flex; justify-content: center; gap: 20px; margin-top: 20px; }
.api-indicator { display: flex; align-items: center; gap: 8px; font-size: 12px; color: #666; }
.api-dot { width: 8px; height: 8px; border-radius: 50%; background: #333; transition: all 0.3s; }
.api-dot.active { background: #00ff00; box-shadow: 0 0 10px rgba(0,255,0,0.5); }
.status-bar { text-align: center; padding: 20px; color: #666; font-size: 13px; letter-spacing: 2px; }
.status-bar.searching { color: #ff0000; animation: pulse 1s infinite; }
@keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.3; } }
.results-area { max-width: 700px; margin: 20px auto; }
.source-header { display: flex; align-items: center; gap: 10px; padding: 10px 0; margin: 20px 0 10px; border-bottom: 1px solid #222; }
.source-dot { width: 12px; height: 12px; border-radius: 50%; }
.source-dot.infinity { background: #ff0000; box-shadow: 0 0 10px rgba(255,0,0,0.5); }
.source-dot.deepsearch { background: #00ff00; box-shadow: 0 0 10px rgba(0,255,0,0.5); }
.source-dot.leakcheck { background: #0080ff; box-shadow: 0 0 10px rgba(0,128,255,0.5); }
.source-name { font-size: 14px; color: #888; letter-spacing: 1px; }
.source-count { font-size: 12px; color: #555; }
.result-card { background: rgba(20,20,20,0.8); border: 1px solid #222; border-radius: 16px; padding: 20px; margin: 12px 0; backdrop-filter: blur(20px); animation: slideUp 0.4s ease-out; transition: all 0.3s; }
.result-card:hover { border-color: #ff0000; box-shadow: 0 0 30px rgba(255,0,0,0.2); transform: translateX(5px); }
@keyframes slideUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
.result-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
.result-source-tag { font-size: 11px; padding: 4px 12px; border-radius: 20px; letter-spacing: 1px; }
.tag-infinity { background: rgba(255,0,0,0.2); color: #ff0000; border: 1px solid rgba(255,0,0,0.3); }
.tag-deepsearch { background: rgba(0,255,0,0.2); color: #00ff00; border: 1px solid rgba(0,255,0,0.3); }
.tag-leakcheck { background: rgba(0,128,255,0.2); color: #0080ff; border: 1px solid rgba(0,128,255,0.3); }
.result-id { font-size: 11px; color: #444; }
.data-grid { display: grid; gap: 8px; }
.data-item { display: flex; padding: 8px 12px; background: rgba(255,255,255,0.02); border-radius: 8px; transition: all 0.2s; }
.data-item:hover { background: rgba(255,255,255,0.05); }
.data-key { color: #666; font-size: 12px; min-width: 100px; letter-spacing: 1px; }
.data-val { color: #ddd; font-size: 14px; word-break: break-all; }
.data-val.password { color: #ff4444; font-family: monospace; letter-spacing: 2px; }
.data-val.email { color: #44ff44; }
.data-val.phone { color: #ffff44; }
.data-val.ip { color: #44ffff; font-family: monospace; }
@media (max-width: 768px) { .sidebar { display: none; } .main-content { margin-left: 0; } }
</style>
</head>
<body>
<canvas id="bgCanvas"></canvas>
<div class="sidebar">
    <div class="profile">
        <div class="profile-avatar">Ω</div>
        <div class="profile-name">OMEGA USER</div>
        <div class="profile-status">Online</div>
    </div>
    <div class="stats">
        <div class="stat-box"><div class="stat-value" id="totalSearches">0</div><div class="stat-label">Поисков</div></div>
        <div class="stat-box"><div class="stat-value" id="totalResults">0</div><div class="stat-label">Найдено</div></div>
        <div class="stat-box"><div class="stat-value">3</div><div class="stat-label">API</div></div>
        <div class="stat-box"><div class="stat-value" id="lastSearch">-</div><div class="stat-label">Последний</div></div>
    </div>
    <div class="menu">
        <div class="menu-item active"><span class="menu-icon">🔍</span> Поиск</div>
        <div class="menu-item"><span class="menu-icon">📊</span> История</div>
        <div class="menu-item"><span class="menu-icon">⚙️</span> Настройки</div>
        <div class="menu-item"><span class="menu-icon">ℹ️</span> О системе</div>
    </div>
    <div style="font-size:10px;color:#333;text-align:center;margin-top:auto;">OMEGA SEARCH v3.0<br>Multi-Source OSINT</div>
</div>
<div class="main-content">
    <div class="logo-section">
        <div class="logo-main">OMEGA</div>
        <div class="logo-sub">SEARCH ENGINE</div>
        <div class="divider"></div>
    </div>
    <div class="search-container">
        <div class="search-box">
            <input type="text" class="search-input" id="searchInput" placeholder="Введите запрос (имя, телефон, email, никнейм)..." />
            <button class="search-btn" id="searchBtn" onclick="doSearch()">🔍 ИСКАТЬ</button>
        </div>
        <div class="api-indicators">
            <div class="api-indicator"><div class="api-dot active" id="dotInfinity"></div>Infinity Check</div>
            <div class="api-indicator"><div class="api-dot" id="dotDeepSearch"></div>DeepSearch</div>
            <div class="api-indicator"><div class="api-dot" id="dotLeakCheck"></div>LeakCheck</div>
        </div>
    </div>
    <div class="status-bar" id="statusBar">ГОТОВ К ПОИСКУ</div>
    <div class="results-area" id="resultsArea"></div>
</div>
<script>
const canvas = document.getElementById('bgCanvas');
const ctx = canvas.getContext('2d');
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;
const particles = [];
for (let i = 0; i < 50; i++) {
    particles.push({ x: Math.random()*canvas.width, y: Math.random()*canvas.height, size: Math.random()*2, speedX: (Math.random()-0.5)*0.5, speedY: (Math.random()-0.5)*0.5, opacity: Math.random() });
}
function animateParticles() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    particles.forEach(p => {
        p.x += p.speedX; p.y += p.speedY;
        if (p.x < 0) p.x = canvas.width;
        if (p.x > canvas.width) p.x = 0;
        if (p.y < 0) p.y = canvas.height;
        if (p.y > canvas.height) p.y = 0;
        ctx.beginPath();
        ctx.arc(p.x, p.y, p.size, 0, Math.PI*2);
        ctx.fillStyle = `rgba(255,0,0,${p.opacity*0.3})`;
        ctx.fill();
    });
    particles.forEach((p1, i) => {
        particles.slice(i+1).forEach(p2 => {
            const dist = Math.hypot(p1.x-p2.x, p1.y-p2.y);
            if (dist < 150) {
                ctx.beginPath();
                ctx.moveTo(p1.x, p1.y);
                ctx.lineTo(p2.x, p2.y);
                ctx.strokeStyle = `rgba(255,0,0,${0.1*(1-dist/150)})`;
                ctx.stroke();
            }
        });
    });
    requestAnimationFrame(animateParticles);
}
animateParticles();
window.addEventListener('resize', () => { canvas.width = window.innerWidth; canvas.height = window.innerHeight; });

let totalSearches = 0, totalResults = 0;
function getSourceTag(source) {
    if (!source) return 'tag-infinity';
    if (source.includes('Infinity')) return 'tag-infinity';
    if (source.includes('DeepSearch')) return 'tag-deepsearch';
    if (source.includes('LeakCheck')) return 'tag-leakcheck';
    return 'tag-infinity';
}
function getValClass(key) {
    if (!key) return '';
    if (key.includes('Пароль')||key.includes('Password')||key.includes('pass')) return 'password';
    if (key.includes('Почта')||key.includes('Email')||key.includes('mail')) return 'email';
    if (key.includes('Телефон')||key.includes('Phone')||key.includes('phone')) return 'phone';
    if (key.includes('IP')||key.includes('ip')) return 'ip';
    return '';
}
function doSearch() {
    const query = document.getElementById('searchInput').value.trim();
    if (!query) return;
    const btn = document.getElementById('searchBtn');
    const statusBar = document.getElementById('statusBar');
    const resultsArea = document.getElementById('resultsArea');
    btn.disabled = true;
    btn.textContent = '⏳ ПОИСК...';
    statusBar.textContent = 'ВЫПОЛНЯЕТСЯ ПОИСК ПО ВСЕМ ИСТОЧНИКАМ...';
    statusBar.className = 'status-bar searching';
    resultsArea.innerHTML = '';
    document.querySelectorAll('.api-dot').forEach(d => d.classList.add('active'));
    fetch('/search', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({query: query})
    })
    .then(r => r.json())
    .then(data => {
        btn.disabled = false;
        btn.textContent = '🔍 ИСКАТЬ';
        statusBar.className = 'status-bar';
        totalSearches++;
        document.getElementById('totalSearches').textContent = totalSearches;
        document.getElementById('lastSearch').textContent = query.substring(0,8);
        if (data.success && data.results && data.results.length > 0) {
            totalResults += data.results.length;
            document.getElementById('totalResults').textContent = totalResults;
            statusBar.textContent = `НАЙДЕНО: ${data.results.length} РЕЗУЛЬТАТОВ`;
            const grouped = {};
            data.results.forEach(card => {
                const source = card.api_source || card.source || 'Infinity Check';
                if (!grouped[source]) grouped[source] = [];
                grouped[source].push(card);
            });
            let html = '', globalIndex = 0;
            for (const [source, cards] of Object.entries(grouped)) {
                const dotClass = source.includes('Infinity') ? 'infinity' : source.includes('DeepSearch') ? 'deepsearch' : 'leakcheck';
                html += `<div class="source-header"><div class="source-dot ${dotClass}"></div><div class="source-name">${source}</div><div class="source-count">${cards.length} записей</div></div>`;
                cards.forEach(card => {
                    globalIndex++;
                    const sourceTag = getSourceTag(card.api_source || card.source);
                    html += `<div class="result-card" style="animation-delay:${globalIndex*0.05}s">`;
                    html += `<div class="result-header"><span class="result-source-tag ${sourceTag}">${card.api_source||card.source||'Unknown'}</span><span class="result-id">#${globalIndex}</span></div>`;
                    html += `<div class="data-grid">`;
                    for (const [key, value] of Object.entries(card)) {
                        if (key==='source'||key==='api_source') continue;
                        const valClass = getValClass(key);
                        html += `<div class="data-item"><span class="data-key">${key}</span><span class="data-val ${valClass}">${value}</span></div>`;
                    }
                    html += `</div></div>`;
                });
            }
            resultsArea.innerHTML = html;
        } else {
            statusBar.textContent = 'НИЧЕГО НЕ НАЙДЕНО';
            resultsArea.innerHTML = `<div style="text-align:center;padding:60px 20px;color:#444;"><div style="font-size:64px;margin-bottom:20px;">🔍</div><div style="font-size:18px;">По запросу "${data.query||query}" ничего не найдено</div><div style="font-size:13px;margin-top:10px;">Попробуйте изменить запрос</div></div>`;
        }
        setTimeout(() => {
            document.querySelectorAll('.api-dot').forEach(d => d.classList.remove('active'));
            document.getElementById('dotInfinity').classList.add('active');
        }, 1000);
    })
    .catch(err => {
        btn.disabled = false;
        btn.textContent = '🔍 ИСКАТЬ';
        statusBar.className = 'status-bar';
        statusBar.textContent = 'ОШИБКА СОЕДИНЕНИЯ';
        resultsArea.innerHTML = `<div style="text-align:center;padding:40px;color:#ff0000;">❌ Ошибка: ${err.message}</div>`;
    });
}
document.getElementById('searchInput').addEventListener('keypress', function(e) { if (e.key==='Enter') doSearch(); });
</script>
</body>
</html>"""

if __name__ == '__main__':
    server = HTTPServer(('0.0.0.0', 8080), Handler)
    print("""
    ╔══════════════════════════════════════╗
    ║   OMEGA SEARCH v3.0                  ║
    ║   Server running on port 8080        ║
    ║   Open: http://localhost:8080        ║
    ╚══════════════════════════════════════╝
    """)
    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print("\nServer stopped")
