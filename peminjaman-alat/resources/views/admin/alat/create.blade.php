{{-- <h3>Tambah Alat</h3>

<form method="POST" action="/admin/alat" enctype="multipart/form-data">
    @csrf

    <input type="text" name="nama_alat" placeholder="Nama alat"><br><br>

    <select name="id_kategori">
        <option value="">-- Pilih Kategori --</option>
        @foreach ($kategori as $k)
        <option value="{{ $k->id_kategori }}">{{ $k->nama_kategori }}</option>
        @endforeach
    </select><br><br>

    <input type="number" name="stok" placeholder="Stok"><br><br>

    <div>
        <label>Gambar Alat</label><br>
        <input type="file" name="gambar" accept="image/*" required>
    </div>

    <button type="submit">Simpan</button>
</form> --}}
