#!/bin/bash

# Operation Nightfall - Startup Script
# Agent Olympics 2026

echo ""
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║           OPERATION NIGHTFALL - CEO Override Protocol         ║"
echo "║                    Agent Olympics 2026                        ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo ""

# Check if virtual environment exists
if [ -d "venv" ]; then
    source venv/bin/activate
    echo "✓ Virtual environment activated"
else
    echo "Creating virtual environment..."
    python3 -m venv venv
    source venv/bin/activate
    pip install -r requirements.txt
    echo "✓ Dependencies installed"
fi

# Start the server
echo ""
echo "🚀 Launching dashboard on http://localhost:8080"
echo "   (Port 8000 is reserved for Joinly server)"
echo ""

python server.py

