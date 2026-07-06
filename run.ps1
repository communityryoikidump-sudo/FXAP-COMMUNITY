# fxap community - Limpador Lua
# Instalador automatico

$ErrorActionPreference = "Stop"
$REPO = "https://raw.githubusercontent.com/communityryoikidump-sudo/FXAP-COMMUNITY/main"
$DEST = "$env:USERPROFILE\Desktop\fxap-lua-cleaner"

# Banner
Clear-Host
Write-Host ""
Write-Host "  ███████╗██╗  ██╗ █████╗ ██████╗ " -ForegroundColor Magenta
Write-Host "  ██╔════╝╚██╗██╔╝██╔══██╗██╔══██╗" -ForegroundColor Magenta
Write-Host "  █████╗   ╚███╔╝ ███████║██████╔╝" -ForegroundColor Magenta
Write-Host "  ██╔══╝   ██╔██╗ ██╔══██║██╔═══╝ " -ForegroundColor Magenta
Write-Host "  ██║     ██╔╝ ██╗██║  ██║██║     " -ForegroundColor Magenta
Write-Host "  ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     " -ForegroundColor Magenta
Write-Host ""
Write-Host "       L I M P A D O R   L U A" -ForegroundColor Cyan
Write-Host "       discord.gg/RkfQN5g3V" -ForegroundColor DarkCyan
Write-Host ""
Write-Host "=================================================================" -ForegroundColor DarkCyan
Write-Host ""

# 1. Verificar Python
Write-Host "[..] Verificando Python..." -ForegroundColor Cyan
$python = $null
foreach ($p in @("python", "python3", "py")) {
    try {
        $ver = & $p --version 2>&1
        if ($ver -match "Python 3") {
            $python = $p
            Write-Host "[OK] Python encontrado: $ver" -ForegroundColor Green
            break
        }
    } catch {}
}

if (-not $python) {
    Write-Host "[ERRO] Python nao encontrado!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Instale o Python em: https://www.python.org/downloads/" -ForegroundColor Yellow
    Write-Host "Marque a opcao 'Add Python to PATH' durante a instalacao." -ForegroundColor Yellow
    Write-Host ""
    pause
    exit 1
}

# 2. Instalar dependencia
Write-Host "[..] Instalando dependencias..." -ForegroundColor Cyan
& $python -m pip install google-generativeai -q
Write-Host "[OK] Dependencias instaladas!" -ForegroundColor Green

# 3. Criar pastas
Write-Host "[..] Criando estrutura de pastas..." -ForegroundColor Cyan
New-Item -ItemType Directory -Path "$DEST\Input"  -Force | Out-Null
New-Item -ItemType Directory -Path "$DEST\Output" -Force | Out-Null

# 4. Baixar main.py
Write-Host "[..] Baixando programa..." -ForegroundColor Cyan
Invoke-WebRequest -Uri "$REPO/main.py" -OutFile "$DEST\main.py"
Write-Host "[OK] Programa baixado!" -ForegroundColor Green

# 5. Criar atalho rodar.bat
$bat = "@echo off`ntitle fxap community - Limpador Lua`nset PYTHONPATH=`nset PYTHONHOME=`ncd /d `"%~dp0`"`n$python main.py`n"
Set-Content -Path "$DEST\rodar.bat" -Value $bat -Encoding ASCII

Write-Host ""
Write-Host "=================================================================" -ForegroundColor DarkCyan
Write-Host "[OK] Instalacao concluida!" -ForegroundColor Green
Write-Host ""
Write-Host "  Pasta criada em: $DEST" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Como usar:" -ForegroundColor White
Write-Host "  1. Coloque seus arquivos .lua em: $DEST\Input" -ForegroundColor White
Write-Host "  2. Clique duas vezes em rodar.bat" -ForegroundColor White
Write-Host "  3. Digite sua chave Gemini (gratis em aistudio.google.com)" -ForegroundColor White
Write-Host ""

# 6. Perguntar se quer rodar agora
$resp = Read-Host "Deseja rodar agora? (s/n)"
if ($resp -eq "s" -or $resp -eq "S") {
    Set-Location $DEST
    & $python main.py
}
