@extends('layouts.petugas')
@section('title','Data Peminjam Aktif')

@section('content')
<div class="row">
        <div class="col-12">
          <div class="card mb-4">
            <div class="card-header pb-0">
              <h6>Cetak Laporan Peminjaman</h6>
                <form action="{{ url('/petugas/laporan/peminjaman') }}" method="GET" target="_blank" class="row g-2 mb-3">
                    <div class="col-md-6">
                        <input type="date" name="from" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <input type="date" name="to" class="form-control" required>
                    </div>
                    <div class="col-md-3">
                        <div class="form-check">
                            <input class="form-check-input"
                                   type="checkbox"
                                   name="show_kategori"
                                   value="1"
                                   id="showKategori"
                                   {{ request('show_kategori') ? 'checked' : '' }}>
                            <label class="form-check-label" for="showKategori">
                                Kategori Alat
                            </label>
                        </div>
                    </div>
                    <div class="col-md-3">
                       <div class="form-check">
                            <input class="form-check-input"
                                   type="checkbox"
                                   name="show_alasan"
                                   value="1"
                                   id="showAlasan"
                                   {{ request('show_alasan') ? 'checked' : '' }}>
                            <label class="form-check-label" for="showAlasan">
                                Alasan (jika status 'ditolak')
                            </label>
                        </div>
                    </div>
                    <div class="col-md-3">
                       <div class="form-check">
                            <input class="form-check-input"
                                   type="checkbox"
                                   name="show_tanggalMengajukan"
                                   value="1"
                                   id="showTanggalMengajukan"
                                   {{ request('show_tanggalMengajukan') ? 'checked' : '' }}>
                            <label class="form-check-label" for="showTanggalMengajukan">
                                Tanggal mengajukan
                            </label>
                        </div>
                    </div>
                    <div class="col-md-3">
                       <div class="form-check">
                            <input class="form-check-input"
                                   type="checkbox"
                                   name="show_tanggalDisetujui"
                                   value="1"
                                   id="showTanggalDisetujui"
                                   {{ request('show_tanggalDisetujui') ? 'checked' : '' }}>
                            <label class="form-check-label" for="showTanggalDisetujui">
                                Tanggal di setujui
                            </label>
                        </div>
                    </div>
                     <div class="col-12">
                        <label class="form-label fw-bold">Status yang ingin ditampilkan:</label>
                    </div>

                    @php
                        $statuses = ['menunggu','dipinjam','dikembalikan','ditolak'];
                    @endphp

                    @foreach($statuses as $status)
                    <div class="col-md-3">
                        <div class="form-check">
                            <input class="form-check-input"
                                   type="checkbox"
                                   name="status[]"
                                   value="{{ $status }}"
                                   id="status_{{ $status }}"
                                   {{ in_array($status, request('status', [])) ? 'checked' : '' }}>
                            <label class="form-check-label" for="status_{{ $status }}">
                                {{ ucfirst($status) }}
                            </label>
                        </div>
                    </div>
                    @endforeach
                    <div class="col-md-12">
                        <button class="btn btn-danger w-100">
                            <i class="fa-solid fa-print" style="color: #ffffff;"></i> Cetak Laporan
                        </button>
                    </div>
                </form>
            </div>
            <div class="card-body px-0 pt-0 pb-2">
              <div class="table-responsive p-0">
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
                            {{ $loop->parent->iteration }}
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
                            @if ($p->tanggal_disetujui)
                                {{ $p->tanggal_disetujui
                                    ->timezone('Asia/Jakarta')
                                    ->translatedFormat('d F Y (H:i:s)') }}
                            @elseif ($p->status === 'ditolak')
                                <span class="text-muted">Tidak disetujui</span>
                            @else
                                <span class="text-muted">Belum disetujui</span>
                            @endif
                        </td>
                      <td class="text-center">
                        @if ($p->status !== 'menunggu' && $p->status !== 'dipinjam')
                            {{ $p->tanggal_kembali->timezone('Asia/Jakarta')->translatedFormat('d F Y (H:i:s)')}}
                        @else
                            -
                        @endif
                      </td>
                      <td class="align-middle text-center">
                        @if($p->status === 'ditolak')
                        <span class="badge badge-sm bg-gradient-danger">{{ ucfirst($p->status) }}</span><br>
                        <small style="color:red; font-size: 11px">
                                Alasan: {{ $p->alasan_ditolak }}
                        </small>
                        @elseif ($p->status === 'menunggu')
                            <span class="badge badge-sm bg-gradient-warning">{{ ucfirst($p->status) }}</span>
                        @elseif ($p->status === 'dipinjam')
                            <span class="badge badge-sm bg-gradient-success">{{ ucfirst($p->status) }}</span>
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
