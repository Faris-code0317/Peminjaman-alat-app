@extends('layouts.admin')
@section('title','Data Kategori')

@section('content')
<div class="row">
        <div class="col-12">
          <div class="card mb-4">
            <div class="card-header pb-0">
              <h6>Data kategori</h6>
            </div>
            <div class="card-body px-0 pt-0 pb-2">
              <div class="table-responsive p-0">
                <button
                    type="button"
                    class="btn btn-sm bg-gradient-success ms-3"
                    data-bs-toggle="modal"
                    data-bs-target="#modalTambahUser">
                    Tambah Kategori
                </button>
                @if (session('error'))
                    <p style="color:red">{{ session('error') }}</p>
                @endif
                <table class="table align-items-center mb-0">
                  <thead>
                    <tr>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">No</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Nama Kategori</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Tanggal Dibuat</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Aksi</th>

                    </tr>
                  </thead>
                  <tbody>
                    @foreach ($kategori as $k)
                    <tr>
                      <td>
                        <div class="d-flex px-3 py-1">
                          <div class="d-flex">
                                {{ $kategori->firstItem() + $loop->index }}
                          </div>
                        </div>
                      </td>
                      <td>
                        {{ $k->nama_kategori }}
                      </td>
                      <td>
                        {{ $k->created_at->translatedFormat('d F Y') }}
                      </td>
                      <td class="align-middle text-center">
                        <a href="#" data-bs-toggle="modal" data-bs-target="#modalEditKategori{{ $k->id_kategori }}">
                            <i class="fa-solid fa-pen-to-square text-success"></i>
                        </a>

                        <form action="/admin/kategori/{{ $k->id_kategori }}" method="POST" style="display:inline" class="d-inline form-delete">
                            @csrf
                            @method('DELETE')
                            <button type="submit" style="border: none; background: none;" class="border-none"><i class="fa-solid fa-trash text-danger"></i></button>
                        </form>
                      </td>
                    </tr>
                    {{-- MODAL EDIT KATEGORI --}}
                    <div class="modal fade" id="modalEditKategori{{ $k->id_kategori }}" tabindex="-1" aria-hidden="true">
                      <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">

                          <form method="POST" action="/admin/kategori/{{ $k->id_kategori }}">
                            @csrf
                            @method('PUT')

                            <div class="modal-header">
                              <h5 class="modal-title">Edit Kategori</h5>
                              <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>

                            <div class="modal-body">

                              <div class="mb-3">
                                <label class="form-label">Nama Kategori</label>
                                <input
                                  type="text"
                                  name="nama_kategori"
                                  class="form-control"
                                  value="{{ $k->nama_kategori }}"
                                  required>
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
                    {{ $kategori->appends(request()->query())->links('pagination::bootstrap-5') }}
                </div>
                {{-- MODAL TAMBAH KATEGORI --}}
                <div class="modal fade" id="modalTambahUser" tabindex="-1" aria-hidden="true">
                  <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">

                      <form method="POST" action="/admin/kategori">
                        @csrf

                        <div class="modal-header">
                          <h5 class="modal-title">Tambah Kategori</h5>
                          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>

                        <div class="modal-body">
                          <div class="mb-3">
                            <label class="form-label">Nama Kategori</label>
                            <input type="text" name="nama_kategori" class="form-control" required>
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

@endsection
{{-- <h3>Data Kategori</h3>

<a href="/admin/kategori/create">Tambah Kategori</a>

@if (session('error'))
<p style="color:red">{{ session('error') }}</p>
@endif

<table border="1" cellpadding="10">
    <tr>
        <th>No</th>
        <th>Nama Kategori</th>
        <th>Aksi</th>
    </tr>

    @foreach ($kategori as $k)
    <tr>
        <td>{{ $loop->iteration }}</td>
        <td>{{ $k->nama_kategori }}</td>
        <td>
            <a href="/admin/kategori/{{ $k->id_kategori }}/edit">Edit</a>

            <form action="/admin/kategori/{{ $k->id_kategori }}" method="POST" style="display:inline" onsubmit="return confirm('Apakah yakin ingin menghapus kategori ini?')">
                @csrf
                @method('DELETE')
                <button type="submit">Hapus</button>
            </form>
        </td>
    </tr>
    @endforeach
</table> --}}
