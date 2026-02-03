{{-- <h3>Data Alat</h3>

<table border="1" cellpadding="10">
    <tr>
        <th>No</th>
        <th>Nama Alat</th>
        <th>Stok</th>
    </tr>

    @foreach ($alat as $a)
    <tr>
        <td>{{ $loop->iteration }}</td>
        <td>{{ $a->nama_alat }}</td>
        <td>{{ $a->stok }}</td>
    </tr>
    @endforeach
</table> --}}

@extends('layouts.petugas')
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
                      {{-- <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Aksi</th> --}}
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
                      {{-- <td class="align-middle text-center">
                         <a href="#" data-bs-toggle="modal" data-bs-target="#modalEditPetugasAdmin{{ $a->id_alat }}">
                            <i class="fa-solid fa-pen-to-square text-success"></i>
                        </a>

                        <form action="/admin/alat/{{ $a->id_alat }}" method="POST" style="display:inline" class="d-inline form-delete">
                            @csrf
                            @method('DELETE')
                            <button type="submit" style="border: none; background: none;" class="border-none"><i class="fa-solid fa-trash text-danger"></i></button>
                        </form>
                      </td> --}}
                    </tr>
                    @endforeach
                  </tbody>
                </table>
                <div class="d-flex justify-content-center mt-4">
                    {{ $alat->appends(request()->query())->links('pagination::bootstrap-5') }}
                </div>
              </div>
            </div>
        </div>
     </div>
</div>
@endsection

