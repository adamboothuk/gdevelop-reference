const { test, expect } = require('playwright/test');
const http = require('http');
const fs = require('fs');
const path = require('path');

const exportDir = process.env.GDEVELOP_EXPORT_DIR ||
  'C:\\GameDev\\AI-Playground\\html5-validation\\arraytools';
const port = Number(process.env.GDEVELOP_SMOKE_PORT || 8061);

function contentType(filePath) {
  const ext = path.extname(filePath).toLowerCase();
  return {
    '.html': 'text/html',
    '.js': 'text/javascript',
    '.json': 'application/json',
    '.css': 'text/css',
    '.png': 'image/png',
    '.jpg': 'image/jpeg',
    '.jpeg': 'image/jpeg',
    '.webp': 'image/webp',
    '.wasm': 'application/wasm',
  }[ext] || 'application/octet-stream';
}

function createServer(root) {
  return http.createServer((req, res) => {
    const requestPath = decodeURIComponent(new URL(req.url, 'http://localhost').pathname);
    const relativePath = requestPath === '/' ? 'index.html' : requestPath.slice(1);
    const filePath = path.normalize(path.join(root, relativePath));

    if (!filePath.startsWith(path.normalize(root))) {
      res.writeHead(403);
      res.end('Forbidden');
      return;
    }

    fs.readFile(filePath, (error, data) => {
      if (error) {
        res.writeHead(404);
        res.end('Not found');
        return;
      }

      res.writeHead(200, { 'Content-Type': contentType(filePath) });
      res.end(data);
    });
  });
}

test.describe('GDevelop exported extension build', () => {
  let server;

  test.beforeAll(async () => {
    const indexPath = path.join(exportDir, 'index.html');
    expect(fs.existsSync(indexPath), `Exported index.html not found: ${indexPath}`).toBe(true);

    server = createServer(exportDir);
    await new Promise((resolve) => server.listen(port, '127.0.0.1', resolve));
  });

  test.afterAll(async () => {
    if (server) {
      await new Promise((resolve) => server.close(resolve));
    }
  });

  test('loads without console errors or failed requests', async ({ page }) => {
    const consoleErrors = [];
    const pageErrors = [];
    const failedRequests = [];

    page.on('console', (message) => {
      if (message.type() === 'error') {
        consoleErrors.push(message.text());
      }
    });
    page.on('pageerror', (error) => pageErrors.push(error.message));
    page.on('requestfailed', (request) => {
      failedRequests.push(`${request.method()} ${request.url()} ${request.failure()?.errorText || ''}`);
    });

    const response = await page.goto(`http://127.0.0.1:${port}/index.html`, {
      waitUntil: 'domcontentloaded',
      timeout: 30000,
    });

    expect(response && response.ok()).toBe(true);

    await page.waitForTimeout(5000);

    const canvasCount = await page.locator('canvas').count();
    const bodyText = await page.locator('body').innerText().catch(() => '');

    console.log(`Export directory: ${exportDir}`);
    console.log(`Canvas count: ${canvasCount}`);
    console.log(`Console errors: ${consoleErrors.length}`);
    console.log(`Page errors: ${pageErrors.length}`);
    console.log(`Failed requests: ${failedRequests.length}`);

    expect(bodyText).not.toContain('Runtime error');
    expect(canvasCount).toBeGreaterThan(0);
    expect(consoleErrors).toEqual([]);
    expect(pageErrors).toEqual([]);
    expect(failedRequests).toEqual([]);
  });
});
