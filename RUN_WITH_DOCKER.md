# Run everything with Docker

## One-time setup
1. Install Docker Desktop and start it.
2. Copy BOTH `mithu-vit.onnx` and `mithu-vit.onnx.data` into the `models/` folder (keep the exact names).
3. Create a free project at supabase.com, then:
   - Supabase dashboard -> SQL Editor -> paste all of `supabase/setup.sql` -> Run.
   - Project Settings -> API: copy the Project URL and the publishable (anon) key.
   - Paste them into `.env` (VITE_SUPABASE_URL, VITE_SUPABASE_PUBLISHABLE_KEY, VITE_SUPABASE_PROJECT_ID).
   - Authentication -> Providers -> Email: turn OFF "Confirm email" (easier for local testing).

## Run
    docker compose up --build

- App:            http://localhost:8080
- Backend health: http://localhost:8000/health  (should show "model_loaded": true)

Stop: Ctrl+C, then `docker compose down`.

If you change `.env`, rebuild: `docker compose up --build`.
CPU only (no GPU needed). Runs fine on a Ryzen CPU, roughly 1-2s per scan.
