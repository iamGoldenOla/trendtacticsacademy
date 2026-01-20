// Enhanced Playground Rendering for course.html
// Add this code to handle embedded simulators (Meta Ads, etc.)

// Replace the existing playground rendering section (around line 708-769) with this:

// 5. INTERACTIVE PLAYGROUND
const playgroundArea = document.getElementById('playgroundArea');
const playground = parseJSON(lesson.playground);
const fallbackPrompt = lesson.playground_prompt;

if (playground || fallbackPrompt) {
    // Check if this is an external simulator (like Meta Ads)
    if (playground && playground.url && playground.embedded) {
        // Render embedded external simulator
        const simulatorUrl = playground.url;
        const objective = playground.objective || 'Interactive Simulator';

        playgroundArea.innerHTML = `
            <div style="margin-top:30px; border:1px solid #1e293b; border-radius:12px; overflow:hidden; background:#0f172a;">
                <div style="padding:15px; background:#1e293b; display:flex; justify-content:space-between; align-items:center;">
                    <div style="font-weight:bold; display:flex; align-items:center; gap:8px;">
                        <span>🎮</span> ${objective}
                    </div>
                    <div style="font-size:0.8rem; color:#94a3b8;">Interactive Simulator</div>
                </div>
                
                <div style="position: relative; width: 100%; height: 800px; background: white;">
                    <iframe 
                        src="${simulatorUrl}" 
                        style="width: 100%; height: 100%; border: none;"
                        title="${objective}"
                        allow="fullscreen"
                    ></iframe>
                </div>
            </div>
        `;
    } else {
        // Render standard AI playground (existing code)
        let promptText = '';
        let objective = 'Vibe Coding Playground';

        if (playground && typeof playground === 'object') {
            promptText = playground.starter_prompt || playground.playground_prompt || '';
            objective = playground.objective || objective;
        } else if (typeof playground === 'string') {
            promptText = playground;
        } else if (fallbackPrompt) {
            promptText = fallbackPrompt;
        }

        // Render the Full Interactive IDE
        playgroundArea.innerHTML = `
            <div style="margin-top:30px; border:1px solid #1e293b; border-radius:12px; overflow:hidden; background:#0f172a;">
                <div style="padding:15px; background:#1e293b; display:flex; justify-content:space-between; align-items:center;">
                    <div style="font-weight:bold; display:flex; align-items:center; gap:8px;">
                        <span>⚡</span> ${objective}
                    </div>
                    <div style="font-size:0.8rem; color:#94a3b8;">AI Playground</div>
                </div>
                
                <div style="display:grid; grid-template-columns: 1fr 1fr; height:500px;">
                    <!-- Input Side -->
                    <div style="border-right:1px solid #1e293b; display:flex; flex-direction:column;">
                        <div style="padding:10px; background:#0f172a; border-bottom:1px solid #1e293b; font-size:0.8rem; color:#94a3b8;">
                            PROMPT INPUT
                        </div>
                        <textarea id="playgroundInput" style="flex:1; background:#020617; color:#e2e8f0; border:none; padding:15px; resize:none; font-family:monospace; line-height:1.5; outline:none;" placeholder="Describe what you want to build...">${promptText}</textarea>
                        <div style="padding:15px; border-top:1px solid #1e293b; background:#0f172a; display:flex; justify-content:flex-end;">
                            <button onclick="runPlayground()" style="background:var(--primary); color:#050B18; border:none; padding:8px 20px; border-radius:6px; font-weight:bold; cursor:pointer; display:flex; align-items:center; gap:8px;">
                                <span>▶</span> Generate
                            </button>
                        </div>
                    </div>
                    
                    <!-- Output Side -->
                    <div style="display:flex; flex-direction:column; background:#1e293b;">
                        <div style="padding:10px; background:#1e293b; border-bottom:1px solid #334155; font-size:0.8rem; color:#94a3b8; display:flex; justify-content:space-between;">
                            <span>LIVE PREVIEW</span>
                            <button onclick="document.getElementById('playgroundFrame').srcdoc=''" style="background:none; border:none; color:#64748b; cursor:pointer; font-size:0.7rem;">RESET</button>
                        </div>
                        <div style="flex:1; background:white; position:relative;">
                            <iframe id="playgroundFrame" style="width:100%; height:100%; border:none;"></iframe>
                            <div id="playgroundLoader" style="position:absolute; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.8); display:none; align-items:center; justify-content:center; color:white; flex-direction:column;">
                                <div class="loader"></div>
                                <div style="margin-top:10px; font-size:0.9rem;">Generating with AI...</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `;
    }
} else {
    playgroundArea.innerHTML = '';
}
