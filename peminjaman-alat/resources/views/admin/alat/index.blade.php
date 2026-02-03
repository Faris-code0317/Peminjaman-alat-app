@extends('layouts.admin')
@section('title','Data Alat')

@section('content')
<div class="row">
        <div class="col-12">
          <div class="card mb-4">
            <div class="card-header pb-0">
              <h6>Data Alat</h6>
            </div>
            <div class="card-body px-0 pt-0 pb-2">
              <div class="table-responsive p-0">
                <button
                    type="button"
                    class="btn btn-sm bg-gradient-success ms-3"
                    data-bs-toggle="modal"
                    data-bs-target="#modalTambahAlat">
                    Tambah Alat
                </button>
                @if (session('error'))
                    <p style="color:red">{{ session('error') }}</p>
                @endif
                <table class="table align-items-center mb-0">
                  <thead>
                    <tr>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">No</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Nama Alat</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Kategori</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Stok</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Gambar</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Aksi</th>
                    </tr>
                  </thead>
                  <tbody>
                    @foreach ($alat as $a)
                    <tr>
                      <td>
                        <div class="d-flex px-3 py-1">
                          <div class="d-flex">
                                {{ $alat->firstItem() + $loop->index }}
                          </div>
                        </div>
                      </td>
                      <td>
                        {{ $a->nama_alat }}
                      </td>
                      <td class="align-middle text-sm">
                        {{ $a->kategori->nama_kategori }}
                      </td>
                      <td class="align-middle text-center">
                         {{ $a->stok }}
                      </td>
                      <td class="align-middle text-center">
                        <img src="{{ asset('storage/alat/' . $a->gambar) }}"
                            width="80"
                            style="border-radius:6px">
                      </td>
                      <td class="align-middle text-center">
                         <a href="#" data-bs-toggle="modal" data-bs-target="#modalEditPetugasAdmin{{ $a->id_alat }}">
                            <i class="fa-solid fa-pen-to-square text-success"></i>
                        </a>

                        <form action="/admin/alat/{{ $a->id_alat }}" method="POST" style="display:inline" class="d-inline form-delete">
                            @csrf
                            @method('DELETE')
                            <button type="submit" style="border: none; background: none;" class="border-none"><i class="fa-solid fa-trash text-danger"></i></button>
                        </form>
                      </td>
                    </tr>
                    {{-- MODAL EDIT ALAT --}}
                    <div class="modal fade" id="modalEditPetugasAdmin{{ $a->id_alat }}" tabindex="-1" aria-hidden="true">
                      <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">

                          <form method="POST" action="/admin/alat/{{ $a->id_alat }}" enctype="multipart/form-data">
                            @csrf
                            @method('PUT')

                            <div class="modal-header">
                              <h5 class="modal-title">Edit Alat</h5>
                              <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>

                            <div class="modal-body">
                                <div class="row">
                                <div class="col-md-6 mb-3">
                                <label class="form-label">Nama Alat</label>
                                <input
                                  type="text"
                                  name="nama_alat"
                                  class="form-control"
                                  value="{{ $a->nama_alat }}"
                                  required>
                                </div>

                                {{-- Kategori --}}
                                <div class="col-md-6 mb-3">
                              <label class="form-label">Kategori</label>
                              <select name="id_kategori" class="form-select" required>
                                 @foreach ($kategori as $k)
                                  <option value="{{ $k->id_kategori }}"
                                      {{ $a->id_kategori == $k->id_kategori ? 'selected' : '' }}>
                                      {{ $k->nama_kategori }}
                                  </option>
                                  @endforeach
                              </select>
                                </div>

                                <div class="col-md-6 mb-3">
                                <label class="form-label">Stok</label>
                                <input
                                  type="text"
                                  name="stok"
                                  class="form-control"
                                  value="{{ $a->stok }}"
                                  required>
                                </div>

                                <div class="col-md-6 mb-3">
                                     <label>Ganti Gambar (opsional)</label><br>
                                     <input type="file" name="gambar" id="gambarEditAlat" class="form-control">
                                </div>

                                <div class="col-12">
                                    <label class="form-label">Gambar Lama</label>
                                    <div class="border rounded p-3 text-center">
                                     @if ($a->gambar)
                                         <img src="{{ asset('storage/alat/' . $a->gambar) }}"
                                              width="120"
                                              style="border-radius:6px; max-height: 180px;">
                                     @else
                                         <p>- Tidak ada gambar -</p>
                                     @endif
                                     </div>
                                </div>
                                {{-- Preview Gambar --}}
                                <div class="col-12">
                                  <label class="form-label">Preview Gambar</label>
                                  <div class="border rounded p-3 text-center">
                                    <img
                                      id="previewEditAlat"
                                      src=""
                                      class="img-fluid d-none"
                                      style="max-height:180px; border-radius: 6px;">
                                    <p id="previewEditText" class="text-muted mb-0">
                                      Belum ada gambar dipilih
                                    </p>
                                  </div>
                                </div>
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
                    {{ $alat->appends(request()->query())->links('pagination::bootstrap-5') }}
                </div>
                {{-- MODAL TAMBAH ALAT --}}
                <div class="modal fade" id="modalTambahAlat" tabindex="-1" aria-hidden="true">
                  <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">

                      <form method="POST" action="/admin/alat" enctype="multipart/form-data">
                        @csrf

                        <div class="modal-header">
                          <h5 class="modal-title">Tambah Alat</h5>
                          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>

                        <div class="modal-body">
                          <div class="row">

                            {{-- Nama Alat --}}
                            <div class="col-md-6 mb-3">
                              <label class="form-label">Nama Alat</label>
                              <input type="text" name="nama_alat" class="form-control" required>
                            </div>

                            {{-- Kategori --}}
                            <div class="col-md-6 mb-3">
                              <label class="form-label">Kategori</label>
                              <select name="id_kategori" class="form-select" required>
                                <option value="">-- Pilih Kategori --</option>
                                @foreach ($kategori as $k)
                                  <option value="{{ $k->id_kategori }}">{{ $k->nama_kategori }}</option>
                                @endforeach
                              </select>
                            </div>

                            {{-- Stok --}}
                            <div class="col-md-6 mb-3">
                              <label class="form-label">Jumlah Stok</label>
                              <input type="number" name="stok" class="form-control" min="0" required>
                            </div>

                            {{-- Upload Gambar --}}
                            <div class="col-md-6 mb-3">
                              <label class="form-label">Gambar Alat</label>
                              <input
                                type="file"
                                name="gambar"
                                class="form-control"
                                accept="image/*"
                                id="gambarTambahAlat"
                                required>
                            </div>

                            {{-- Preview Gambar --}}
                            <div class="col-12">
                              <label class="form-label">Preview Gambar</label>
                              <div class="border rounded p-3 text-center">
                                <img
                                  id="previewTambahAlat"
                                  src=""
                                  class="img-fluid d-none"
                                  style="max-height:180px">
                                <p id="previewText" class="text-muted mb-0">
                                  Belum ada gambar dipilih
                                </p>
                              </div>
                            </div>

                          </div>
                        </div>

                        <div class="modal-footer">
                          <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">
                            Batal
                          </button>
                          <button type="submit" class="btn bg-gradient-success">
                            Simpan
                          </button>
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

{{-- <h3>Data Alat</h3>

<a href="/admin/alat/create">Tambah Alat</a>

@if (session('error'))
<p style="color:red">{{ session('error') }}</p>
@endif

<table border="1" cellpadding="10">
    <tr>
        <th>No</th>
        <th>Nama Alat</th>
        <th>Kategori</th>
        <th>Stok</th>
        <th>Gambar</th>
        <th>Aksi</th>
    </tr>

    @foreach ($alat as $a)
    <tr>
        <td>{{ $loop->iteration }}</td>
        <td>{{ $a->nama_alat }}</td>
        <td>{{ $a->kategori->nama_kategori }}</td>
        <td>{{ $a->stok }}</td>
        <td>
            <img src="{{ asset('storage/alat/' . $a->gambar) }}"
                 width="80"
                 style="border-radius:6px">
        </td>
        <td>
            <a href="/admin/alat/{{ $a->id_alat }}/edit">Edit</a>

            <form action="/admin/alat/{{ $a->id_alat }}" method="POST" style="display:inline" onsubmit="return confirm('Apakah yakin ingin menghapus alat ini?')">
                @csrf
                @method('DELETE')
                <button type="submit">🗑️</button>
            </form>
        </td>
    </tr>
    @endforeach
</table> --}}
