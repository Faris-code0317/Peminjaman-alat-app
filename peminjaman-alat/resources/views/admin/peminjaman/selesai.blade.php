{{-- <h3>Peminjaman Selesai</h3>

<table border="1" cellpadding="10">
    <tr>
        <th>No</th>
        <th>Nama Peminjam</th>
        <th>Tanggal Pinjam</th>
        <th>Detail Alat</th>
        <th>Gambar</th>
        <th>Aksi</th>
    </tr>

@foreach ($peminjaman as $p)
<tr>
    <td>{{ $peminjaman->firstItem() + $loop->index }}</td>
    <td>{{ $p->user->nama_lengkap }}</td>
    <td>{{ $p->tanggal_pinjam }}</td>

    <td>
        <ul>
            @foreach ($p->detail as $d)
                <li>
                    {{ $d->alat->nama_alat ?? '-' }}
                    ({{ $d->jumlah }})
                </li>
            @endforeach
        </ul>
    </td>

    <td>
        @foreach ($p->detail as $d)
            @if ($d->alat && $d->alat->gambar)
                <img src="{{ asset('storage/alat/' . $d->alat->gambar) }}"
                     width="70"
                     style="margin-bottom:5px;border-radius:6px">
            @endif
        @endforeach
    </td>

    <td>
        <form method="POST"
              action="/admin/peminjaman/{{ $p->id_peminjaman }}"
              onsubmit="return confirm('Yakin hapus data ini?')">
            @csrf
            @method('DELETE')
            <button type="submit">Hapus</button>
        </form>
    </td>
</tr>
@endforeach
</table> --}}


@extends('layouts.admin')
@section('title','Data Peminjam Aktif')

@section('content')
<div class="row">
        <div class="col-12">
          <div class="card mb-4">
            <div class="card-header pb-0">
              <h6>Data Peminjam Selesai</h6>
            </div>
            <div class="card-body px-0 pt-0 pb-2">
              <div class="table-responsive p-0">
                <table class="table align-items-center mb-0">
                  <thead>
                    <tr>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">No</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Nama Peminjam</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Tanggal Pinjam</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Tanggal Kembali</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Detail Alat</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Gambar</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Status</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Aksi</th>
                    </tr>
                  </thead>
                  <tbody>
                    @foreach ($peminjaman as $p)
                    <tr>
                      <td>
                        <div class="d-flex px-3 py-1">
                          <div class="d-flex">
                            {{ $peminjaman->firstItem() + $loop->index }}
                          </div>
                        </div>
                      </td>
                      <td>
                        {{ $p->user->nama_lengkap }}
                      </td>
                      <td class="align-middle text-center">
                        {{ $p->tanggal_pinjam->translatedFormat('d F Y') }}
                      </td>
                      <td class="align-middle text-center">
                        {{ $p->tanggal_kembali->translatedFormat('d F Y') }}
                      </td>
                      <td class="align-middle text-center">
                            @foreach ($p->detail as $d)
                                    {{ $d->alat->nama_alat ?? '-' }}
                                    ({{ $d->jumlah }})
                            @endforeach
                      </td>
                      <td class="align-middle text-center">
                         @foreach ($p->detail as $d)
                            @if ($d->alat && $d->alat->gambar)
                                <img src="{{ asset('storage/alat/' . $d->alat->gambar) }}"
                                     width="70"
                                     style="margin-bottom:5px;border-radius:6px">
                            @endif
                        @endforeach
                      </td>
                      <td class="align-middle text-center">
                        @if ($p->status === 'dikembalikan')
                            <span class="badge badge-sm bg-gradient-primary">{{ ucfirst($p->status) }}</span>
                        @else
                            <span class="badge badge-sm bg-gradient-danger">{{ ucfirst($p->status) }}</span>
                            <br>
                            <small style="color:red">
                                Alasan: {{ $p->alasan_ditolak }}
                            </small>
                        @endif
                      </td>
                      <td>
                        <form action="/admin/peminjaman/{{ $p->id_peminjaman }}" method="POST" style="display:inline" class="d-inline form-delete">
                            @csrf
                            @method('DELETE')
                            <button type="submit" style="border: none; background: none;" class="border-none"><i class="fa-solid fa-trash text-danger"></i></button>
                        </form>
                      </td>
                    </tr>
                    @endforeach
                  </tbody>
                </table>
                <div class="d-flex justify-content-center mt-4">
                    {{ $peminjaman->appends(request()->query())->links('pagination::bootstrap-5') }}
                </div>
              </div>
            </div>
        </div>
     </div>
</div>
@endsection
