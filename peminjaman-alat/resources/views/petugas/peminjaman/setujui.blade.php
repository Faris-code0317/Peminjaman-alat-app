
@extends('layouts.petugas')
@section('title','Data Peminjam Aktif')

@section('content')
<div class="row">
        <div class="col-12">
          <div class="card mb-4">
            <div class="card-header pb-0">
              <h6>Data Permintaan Peminjaman</h6>
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
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Jumlah</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Stok Saat Ini</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Tanggal Permintaan</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Status</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Gambar</th>
                        <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Aksi</th>
                    </tr>
                  </thead>
                  <tbody>
                    @php
                        $no = $peminjaman->firstItem();
                    @endphp
                    @foreach ($peminjaman as $p)
                        @foreach ($p->detail as $d)
                    <tr>
                      <td>
                        <div class="d-flex px-3 py-1">
                          <div class="d-flex">
                            {{ $no++ }}
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
                      <td class="align-middle text-center">
                            <span class="badge badge-sm bg-gradient-warning">{{ ucfirst($p->status) }}</span>
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
                      <td class="text-center">
                        {{-- SETUJUI --}}
                        <form action="/petugas/peminjaman/{{ $p->id_peminjaman }}/setujui"
                              method="POST"
                              style="display:inline"
                              class="form-setujui">
                            @csrf
                            <button tsubmmit class="btn-none" style="background: none; border: none ;"><i class="fa-regular fa-circle-check" style="color: #15b300;"></i></button>
                        </form>

                        {{-- TOLAK --}}
                        <a href="#" data-bs-toggle="modal" data-bs-target="#modalInputAlasan{{ $p->id_peminjaman }}">
                            <i class="fa-solid fa-circle-minus" style="color: #ff0000;"></i>
                        </a>
                      </td>
                    </tr>
                    {{-- INPUT ALASAN --}}
                    <div class="modal fade" id="modalInputAlasan{{ $p->id_peminjaman }}" tabindex="-1" aria-hidden="true">
                      <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                          <form method="POST" id="form-tolak-{{ $p->id_peminjaman }}" action="/petugas/peminjaman/{{ $p->id_peminjaman }}/tolak">
                            @csrf
                            <div class="modal-header">
                              <h5 class="modal-title">Maukan Alasan</h5>
                              <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>

                            <div class="modal-body">

                              <div class="mb-3">
                                <label class="form-label">Alasan :</label>
                                <input
                                  type="text"
                                  name="alasan"
                                  class="form-control"
                                  placeholder="Alasan penolakan"
                                  required>
                              </div>

                            </div>

                            <div class="modal-footer">
                              <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                              <button type="submit" class="btn bg-gradient-danger">Kirim</button>
                            </div>

                          </form>

                        </div>
                      </div>
                    </div>
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

