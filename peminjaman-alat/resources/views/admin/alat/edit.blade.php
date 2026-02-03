{{-- <h3>Edit Alat</h3>

<form method="POST" action="/admin/alat/{{ $alat->id_alat }}" enctype="multipart/form-data">
    @csrf
    @method('PUT')

    <input type="text" name="nama_alat" value="{{ $alat->nama_alat }}"><br><br>

    <select name="id_kategori">
        @foreach ($kategori as $k)
        <option value="{{ $k->id_kategori }}"
            {{ $alat->id_kategori == $k->id_kategori ? 'selected' : '' }}>
            {{ $k->nama_kategori }}
        </option>
        @endforeach
    </select><br><br>

    <input type="number" name="stok" value="{{ $alat->stok }}"><br><br>

    <div>
        <label>Gambar Lama</label><br>
        @if ($alat->gambar)
            <img src="{{ asset('storage/alat/' . $alat->gambar) }}"
                 width="120"
                 style="border-radius:6px">
        @else
            <p>- Tidak ada gambar -</p>
        @endif
    </div>

    <div>
        <label>Ganti Gambar (opsional)</label><br>
        <input type="file" name="gambar">
    </div>

    <button type="submit">Update</button>
</form> --}}
