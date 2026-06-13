-- PostgreSQL Index Optimization for Calibre OpenClaw Server
-- Run as calibre_openclaw user (no superuser required)

-- 1. Add partial index for faster COUNT queries on book_chunks
-- This index only covers rows with embeddings, making COUNT(* WHERE embedding IS NOT NULL) much faster
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_book_chunks_embedding_exists 
ON book_chunks (book_id) 
WHERE embedding IS NOT NULL;

-- 2. Add index for processing_queue status queries
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_processing_queue_status 
ON processing_queue (status);

-- 3. Add index for download_queue status queries
CREATE INDEX CONCURRENTLY IF NOT EXISTS idx_download_queue_status 
ON download_queue (status);

-- Note: Run with: PGPASSWORD=your_password psql -h localhost -U calibre_openclaw -d calibre_openclaw -f postgresql_optimization.sql
