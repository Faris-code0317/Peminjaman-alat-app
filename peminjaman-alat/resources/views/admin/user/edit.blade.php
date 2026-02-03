{{-- <h3>Edit User</h3>

<form method="POST" action="/admin/user/{{ $user->id_user }}">
    @csrf
    @method('PUT')

    <input type="text" name="nama_lengkap" value="{{ $user->nama_lengkap }}"><br><br>

    <input type="password" name="password" placeholder="Password baru (opsional)"><br><br>

    <select name="role">
        <option value="admin" {{ $user->role == 'admin' ? 'selected' : '' }}>Admin</option>
        <option value="petugas" {{ $user->role == 'petugas' ? 'selected' : '' }}>Petugas</option>
        <option value="peminjam" {{ $user->role == 'peminjam' ? 'selected' : '' }}>Peminjam</option>
    </select><br><br>

    <button type="submit">Update</button>
</form> --}}
