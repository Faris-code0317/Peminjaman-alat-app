
@extends('layouts.admin')
@section('title','Data User')

@section('content')
<div class="row">
        <div class="col-12">
          <div class="card mb-4">
            <div class="card-header pb-0">
              <h6>Data admin/petugas</h6>
            </div>
            <div class="card-body px-0 pt-0 pb-2">
              <div class="table-responsive p-0">
                <button
                    type="button"
                    class="btn btn-sm bg-gradient-success ms-3"
                    data-bs-toggle="modal"
                    data-bs-target="#modalTambahUser">
                    Tambah Data
                </button>
                <table class="table align-items-center mb-0">
                  <thead>
                    <tr>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">No</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Nama</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Username</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Role</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Aksi</th>
                    </tr>
                  </thead>
                  <tbody>
                    @foreach ($admin as $u)
                    <tr>
                      <td>
                        <div class="d-flex px-3 py-1">
                          <div class="d-flex">
                                {{ $loop->iteration }}
                          </div>
                        </div>
                      </td>
                      <td>
                        {{ $u->nama_lengkap }}
                      </td>
                      <td class="align-middle text-sm">
                        {{ $u->username }}
                      </td>
                      <td class="align-middle text-center">
                         @if ($u->role === 'admin')
                            <span class="badge badge-sm bg-gradient-warning">{{ ucfirst($u->role) }}</span>
                        @else
                            <span class="badge badge-sm bg-gradient-primary">{{ ucfirst($u->role) }}</span>
                        @endif
                      </td>
                      <td class="align-middle text-center">
                        <a href="#" data-bs-toggle="modal" data-bs-target="#modalEditPetugasAdmin{{ $u->id_user }}">
                            <i class="fa-solid fa-pen-to-square text-success"></i>
                        </a>

                        <form action="/admin/user/{{ $u->id_user }}" method="POST" style="display:inline" class="d-inline form-delete">
                            @csrf
                            @method('DELETE')
                            <button type="submit" style="border: none; background: none;" class="border-none"><i class="fa-solid fa-trash text-danger"></i></button>
                        </form>
                      </td>
                    </tr>

                    {{-- MODAL EDIT USER --}}
                    <div class="modal fade" id="modalEditPetugasAdmin{{ $u->id_user }}" tabindex="-1" aria-hidden="true">
                      <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">

                          <form method="POST" action="/admin/user/{{ $u->id_user }}">
                            @csrf
                            @method('PUT')

                            <div class="modal-header">
                              <h5 class="modal-title">Edit User</h5>
                              <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>

                            <div class="modal-body">

                              <div class="mb-3">
                                <label class="form-label">Nama Lengkap</label>
                                <input
                                  type="text"
                                  name="nama_lengkap"
                                  class="form-control"
                                  value="{{ $u->nama_lengkap }}"
                                  required>
                              </div>

                              <div class="mb-3">
                                <label class="form-label">Password Baru (opsional)</label>
                                <input
                                  type="password"
                                  name="password"
                                  class="form-control"
                                  placeholder="Kosongkan jika tidak diganti">
                              </div>

                              <div class="mb-3">
                                <label class="form-label">Role</label>
                                <select name="role" class="form-select" required>
                                  <option value="admin" {{ $u->role == 'admin' ? 'selected' : '' }}>Admin</option>
                                  <option value="petugas" {{ $u->role == 'petugas' ? 'selected' : '' }}>Petugas</option>
                                  <option value="peminjam" {{ $u->role == 'peminjam' ? 'selected' : '' }}>Peminjam</option>
                                </select>
                              </div>

                            </div>

                            <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                              <button type="submit" class="btn bg-gradient-success">Update</button>
                            </div>

                          </form>

                        </div>
                      </div>
                    </div>
                    @endforeach
                  </tbody>
                </table>
                <div class="d-flex justify-content-center mt-4">
                    {{ $admin->appends(request()->query())->links('pagination::bootstrap-5') }}
                </div>

                {{-- MODAL TAMBAH USER --}}
                <div class="modal fade" id="modalTambahUser" tabindex="-1" aria-hidden="true">
                  <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">

                      <form method="POST" action="/admin/user">
                        @csrf

                        <div class="modal-header">
                          <h5 class="modal-title">Tambah User</h5>
                          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>

                        <div class="modal-body">
                          <div class="mb-3">
                            <label class="form-label">Nama Lengkap</label>
                            <input type="text" name="nama_lengkap" class="form-control" required>
                          </div>

                          <div class="mb-3">
                            <label class="form-label">Username</label>
                            <input type="text" name="username" class="form-control" required>
                          </div>

                          <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" name="password" class="form-control" required>
                          </div>

                          <div class="mb-3">
                            <label class="form-label">Role</label>
                            <select name="role" class="form-select" required>
                              <option value="">-- Pilih Role --</option>
                              <option value="admin">Admin</option>
                              <option value="petugas">Petugas</option>
                              <option value="peminjam">Peminjam</option>
                            </select>
                          </div>
                        </div>

                        <div class="modal-footer">
                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                          <button type="submit" class="btn bg-gradient-success">Simpan</button>
                        </div>

                      </form>

                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {{-- Table peminjam --}}

      <div class="row">
        <div class="col-12">
          <div class="card mb-4">
            <div class="card-header pb-0">
              <h6>Data peminjam</h6>
            </div>
            <div class="card-body px-0 pt-0 pb-2">
              <div class="table-responsive p-0">
                                   <table class="table align-items-center mb-0">
                  <thead>
                    <tr>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">No</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Nama</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Username</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Role</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Aksi</th>
                    </tr>
                  </thead>
                  <tbody>
                    @foreach ($user as $u)
                    <tr>
                      <td>
                        <div class="d-flex px-3 py-1">
                          <div class="d-flex">
                                {{  $user->firstItem() + $loop->index }}
                          </div>
                        </div>
                      </td>
                      <td>
                        {{ $u->nama_lengkap }}
                      </td>
                      <td class="align-middle text-sm">
                        {{ $u->username }}
                      </td>
                      <td class="align-middle text-center">
                            <span class="badge badge-sm bg-gradient-success">{{ ucfirst($u->role) }}</span>
                      </td>
                      <td class="align-middle text-center">
                         <a href="#" data-bs-toggle="modal" data-bs-target="#modalEditUser{{ $u->id_user }}">
                            <i class="fa-solid fa-pen-to-square text-success"></i>
                        </a>

                        <form action="/admin/user/{{ $u->id_user }}" method="POST" style="display:inline" class="d-inline form-delete">
                            @csrf
                            @method('DELETE')
                            <button type="submit" style="border: none; background: none;" class="border-none"><i class="fa-solid fa-trash text-danger"></i></button>
                        </form>
                      </td>
                    </tr>
                    {{-- MODAL EDIT USER --}}
                    <div class="modal fade" id="modalEditUser{{ $u->id_user }}" tabindex="-1" aria-hidden="true">
                      <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">

                          <form method="POST" action="/admin/user/{{ $u->id_user }}">
                            @csrf
                            @method('PUT')

                            <div class="modal-header">
                              <h5 class="modal-title">Edit User</h5>
                              <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>

                            <div class="modal-body">

                              <div class="mb-3">
                                <label class="form-label">Nama Lengkap</label>
                                <input
                                  type="text"
                                  name="nama_lengkap"
                                  class="form-control"
                                  value="{{ $u->nama_lengkap }}"
                                  required>
                              </div>

                              <div class="mb-3">
                                <label class="form-label">Password Baru (opsional)</label>
                                <input
                                  type="password"
                                  name="password"
                                  class="form-control"
                                  placeholder="Kosongkan jika tidak diganti">
                              </div>

                              <div class="mb-3">
                                <label class="form-label">Role</label>
                                <select name="role" class="form-select" required>
                                  <option value="admin" {{ $u->role == 'admin' ? 'selected' : '' }}>Admin</option>
                                  <option value="petugas" {{ $u->role == 'petugas' ? 'selected' : '' }}>Petugas</option>
                                  <option value="peminjam" {{ $u->role == 'peminjam' ? 'selected' : '' }}>Peminjam</option>
                                </select>
                              </div>

                            </div>

                            <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                              <button type="submit" class="btn bg-gradient-success">Update</button>
                            </div>

                          </form>

                        </div>
                      </div>
                    </div>
                    @endforeach
                  </tbody>
                </table>
                <div class="d-flex justify-content-center mt-4">
                    {{ $user->appends(request()->query())->links('pagination::bootstrap-5') }}
                </div>
              </div>
            </div>
        </div>
    </div>
</div>

@if ($errors->any())
<script>
    document.addEventListener('DOMContentLoaded', function () {
        new bootstrap.Modal(document.getElementById('modalTambahUser')).show();
    });
</script>
@endif

@endsection


{{-- <table border="1" cellpadding="10">
    <tr>
        <th>No</th>
        <th>Nama</th>
        <th>Username</th>
        <th>Role</th>
        <th>Aksi</th>
    </tr>

    @foreach ($user as $u)
    <tr>
        <td>{{ $loop->iteration }}</td>
        <td>{{ $u->nama_lengkap }}</td>
        <td>{{ $u->username }}</td>
        <td>
            @if ($u->role === 'admin')
                <span class="badge badge-sm bg-gradient-success">{{ ucfirst($u->role) }}</span>
            @else
                <span class="badge badge-sm bg-gradient-secondary">{{ ucfirst($u->role) }}</span>
            @endif
        </td>
        <td>
            <a href="/admin/user/{{ $u->id_user }}/edit">Edit</a>

            <form action="/admin/user/{{ $u->id_user }}" method="POST" style="display:inline" onsubmit="return confirm('Apakah yakin ingin menghapus role ini?')">
                @csrf
                @method('DELETE')
                <button type="submit">Hapus</button>
            </form>
        </td>
    </tr>
    @endforeach
</table> --}}
