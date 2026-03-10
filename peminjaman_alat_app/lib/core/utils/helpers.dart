String getImageUrl(String gambar) {
  // If gambar contains multiple /api/image/, extract the filename from the last part
  if (gambar.contains('/api/image/')) {
    final parts = gambar.split('/api/image/');
    if (parts.length > 1) {
      final lastPart = parts.last;
      // If the last part still contains /api/image/, split again
      if (lastPart.contains('/api/image/')) {
        final subParts = lastPart.split('/api/image/');
        final filename = subParts.last;
        return 'http://127.0.0.1:8000/api/image/$filename';
      } else {
        // Check if lastPart is already a full URL
        if (lastPart.startsWith('http')) {
          return lastPart;
        } else {
          return 'http://127.0.0.1:8000/api/image/$lastPart';
        }
      }
    }
  }
  
  // If it's just a filename, construct the full URL
  if (!gambar.startsWith('http')) {
    return 'http://127.0.0.1:8000/api/image/$gambar';
  }
  
  // If it's already a proper URL, return as is
  return gambar;
}
