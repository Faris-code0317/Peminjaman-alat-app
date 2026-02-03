{{-- <h3>Data Peminjaman</h3>

<table border="1" cellpadding="10">
    <tr>
        <th>No</th>
        <th>Username Peminjam</th>
        <th>Nama Alat</th>
        <th>Jumlah</th>
        <th>Stok Saat Ini</th>
        <th>Tanggal Permintaan</th>
        <th>Tanggal Disetujui</th>
        <th>Tanggal Dikembalikan</th>
        <th>Status</th>
        <th>Gambar Alat</th>
    </tr>

@foreach ($peminjaman as $p)
    @foreach ($p->detail as $d)
    <tr>
        <td>{{ $loop->parent->iteration }}</td>
        <td>{{ $p->user->nama_lengkap }}</td>
        <td>{{ $d->alat->nama_alat ?? '-' }}</td>
        <td>{{ $d->jumlah }}</td>
        <td>{{ $d->alat->stok ?? '-' }}</td>
        <td>{{ $p->tanggal_pinjam->timezone('Asia/Jakarta')->translatedFormat('d F Y (H:i:s)') }}</td>
        <td>{{ $p->tanggal_disetujui->timezone('Asia/Jakarta')->translatedFormat('d F Y (H:i:s)') }}</td>
        <td>{{ $p->tanggal_kembali->timezone('Asia/Jakarta')->translatedFormat('d F Y (H:i:s)') }}</td>
        <td>
            {{ ucfirst($p->status) }}
            @if ($p->status === 'ditolak')
                <br>
                <small style="color:red">
                    Alasan: {{ $p->alasan_ditolak }}
                </small>
            @endif
        </td>
        <td>
           <img src="{{ asset('storage/alat/' . $d->alat->gambar) }}"
                width="80"
                style="border-radius:6px">
        </td>
    </tr>
    @endforeach
@endforeach
</table>

<script>
function showTolakForm(id) {
    document.getElementById('form-tolak-' + id).style.display = 'block';
}
</script> --}}

@extends('layouts.petugas')
@section('title','Data Peminjam Aktif')

@section('content')
<div class="row">
        <div class="col-12">
          <div class="card mb-4">
            <div class="card-header pb-0">
              <h6>Data Peminjaman</h6>
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
                        <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Username Peminjam</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Nama Alat</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Jumlah Dipinjam</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Stok Saat Ini</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Tanggal Permintaan</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Tanggal Disetujui</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Tanggal Dikembalikan</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Status</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Gambar</th>
                    </tr>
                  </thead>
                  <tbody>
                    @foreach ($peminjaman as $p)
                        @foreach ($p->detail as $d)
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
                      <td class="align-middle text-sm">
                        {{ $d->alat->nama_alat ?? '-' }}
                      </td>
                      <td class="text-center">
                        {{ $d->jumlah }}
                      </td>
                      <td class="text-center">
                        {{ $d->alat->stok ?? '-' }}
                      </td>
                      <td>
                        {{ $p->tanggal_pinjam->timezone('Asia/Jakarta')->translatedFormat('d F Y (H:i:s)') }}
                      </td>
                      <td class="text-center">
                          {{ $p->tanggal_disetujui?->timezone('Asia/Jakarta')
                              ?->translatedFormat('d F Y (H:i:s)') ?? '-' }}
                      </td>
                      <td>
                        {{ $p->tanggal_kembali->timezone('Asia/Jakarta')->translatedFormat('d F Y (H:i:s)') }}
                      </td>
                      <td class="align-middle text-center">
                        @if(ucfirst($p->status === 'ditolak'))
                        <span class="badge badge-sm bg-gradient-danger">{{ ucfirst($p->status) }}</span><br>
                        <small style="color:red; font-size: 11px">
                                Alasan: {{ $p->alasan_ditolak }}
                        </small>
                        @else
                        <span class="badge badge-sm bg-gradient-primary">{{ ucfirst($p->status) }}</span>
                        @endif
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
                    </tr>
                    @endforeach
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
