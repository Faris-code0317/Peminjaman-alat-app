{{-- <h2>Log Arsip (Log Cache)</h2>

<form method="GET" action="">
    <select name="role">
        <option value="">-- Semua Role --</option>
        <option value="admin" {{ request('role')=='admin'?'selected':'' }}>Admin</option>
        <option value="petugas" {{ request('role')=='petugas'?'selected':'' }}>Petugas</option>
        <option value="peminjam" {{ request('role')=='peminjam'?'selected':'' }}>Peminjam</option>
        <option value="system" {{ request('role')=='system'?'selected':'' }}>System</option>
    </select>

    <input type="date" name="tanggal" value="{{ request('tanggal') }}">

    <button type="submit">Filter</button>
    <a href="{{ route('admin.logcache.index') }}">Reset</a>
</form>

<a href="/admin/log-aktivitas">← Kembali</a>

<hr>

<table border="1" cellpadding="8">
    <tr>
        <th>No</th>
        <th>Waktu</th>
        <th>Nama User</th>
        <th>Role</th>
        <th>Aktivitas</th>
        <th>Keterangan</th>
        <th>Dihapus Pada</th>
        <th>Dihapus Oleh</th>
    </tr>

    @foreach ($logCache as $item)
    <tr>
        <td>{{ $logCache->firstItem() + $loop->index }}</td>
        <td>{{ $item->created_at }}</td>
        <td>{{ $item->nama_user }}</td>
        <td>{{ ucfirst($item->role) }}</td>
        <td>{{ $item->aktivitas }}</td>
        <td>
            {{ $item->keterangan }}
            <small>
                Log ini dihapus oleh <b>{{ $item->deleted_by }}</b>
                pada {{ \Carbon\Carbon::parse($item->deleted_at)->format('d-m-Y H:i') }}
            </small>
        </td>
        <td>{{ $item->deleted_at }}</td>
        <td>{{ $item->deleted_by }}</td>
    </tr>
    @endforeach
</table>
<div style="margin-top:15px">
    {{ $logCache->links() }}
</div> --}}


@extends('layouts.admin')
@section('title','Data Peminjam Aktif')

@section('content')
<div class="row">
        <div class="col-12">
          <div class="card mb-4">
            <div class="card-header pb-0">
                <h6>
                    Log Arsip (Log Cache)
                </h6>
            </div>
            <div class="card-body px-0 pt-0 pb-2">
              <div class="table-responsive p-0">
                <table class="table align-items-center mb-0">
                  <thead>
                    <tr>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">No</th>
                      <th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Waktu</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">Nama User</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Role</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Aktivitas</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Keterangan</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Dihapus Pada</th>
                      <th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">Dihapus Oleh</th>
                    </tr>
                  </thead>
                  <tbody>
                    @foreach ($logCache as $item)
                    <tr>
                        <td>
                          <div class="d-flex px-3 py-1">
                            <div class="d-flex">
                              {{ $logCache->firstItem() + $loop->index }}
                            </div>
                          </div>
                        </td>
                        <td>
                          {{ $item->created_at }}
                        </td>
                        <td class="align-middle text-sm">
                          {{ $item->nama_user }}
                        </td>
                        <td class="align-middle text-center">
                          {{ ucfirst($item->role) }}
                        </td>
                        <td class="align-middle text-center">
                          {{ $item->aktivitas }}
                        </td>
                        <td class="align-middle text-sm">
                          {{ $item->keterangan }}
                          <small>
                              Log ini dihapus oleh <b>{{ $item->deleted_by }}</b>
                              pada {{ \Carbon\Carbon::parse($item->deleted_at)->format('d-m-Y H:i') }}
                          </small>
                        </td>
                        <td>{{ $item->deleted_at }}</td>
                        <td class="text-center">{{ $item->deleted_by }}</td>
                    </tr>
                    @endforeach
                  </tbody>
                </table>
                <div class="d-flex justify-content-center mt-4">
                    {{ $logCache->appends(request()->query())->links('pagination::bootstrap-5') }}
                </div>
              </div>
            </div>
        </div>
     </div>
</div>
@endsection
