<!DOCTYPE html>
<html>
<head>
    <style>
        table { width:100%; border-collapse: collapse; }
        th, td { border:1px solid black; padding:5px; font-size:12px; }
    </style>
</head>
<body>

<table width="100%">
    <tr>
        <td width="15%" style="text-align: center">
            <img src="{{ public_path('logo.png') }}" width="80">
        </td>
        <td align="center">
            <h3>LAPORAN PEMINJAMAN ALAT</h3>
            <p>SMK / KAPROGSIS AL ITTIHAD</p>
            <p>Periode {{ $from }} s/d {{ $to }}</p>
        </td>
        <td width="15%" style="text-align: center">
            <img src="{{ public_path('logoPPLG.png') }}" width="80">
        </td>
    </tr>
</table>

<hr>

<table>
    <thead>
        <tr>
            <th>No</th>
            <th>Nama User</th>
            <th>Nama Alat</th>
            <th>Kategori Alat</th>
            <th>Jumlah</th>
            <th>Status</th>
            <th>Alasan</th>
            <th>Tanggal</th>
        </tr>
    </thead>
    <tbody>
        @foreach($peminjaman as $p)
            @foreach ($p->detail as $d)
        <tr>
            <!-- No -->
            <td style="text-align: center">{{ $loop->parent->iteration }}</td>

            <!-- Nama User -->
            <td>{{ $p->user->nama_lengkap }}</td>

            <!-- Nama Alat -->
            <td>
                {{ $d->alat->nama_alat ?? '-' }}
            </td>

            <!-- Nama Kategori -->
            <td>
                {{ $d->alat->kategori->nama_kategori }}
            </td>

            <!-- Jumlah Alat -->
            <td style="text-align:center">
                {{ $d->jumlah }}
            </td>

            <!-- Status -->
             @if ( $p->status === 'ditolak' )
                <td style="color: red; text-align:center;">
                  {{ $p->status }}
                </td>
             @elseif ($p->status === 'dikembalikan')
                <td style="color: blue; text-align:center;">
                   {{ $p->status }}
                </td>
             @elseif ($p->status === 'menunggu')
                <td style="color: orange; text-align:center;">
                    {{ $p->status }}
                </td>
             @else
                <td style="color: green; text-align:center;">
                    {{ $p->status }}
                </td>
             @endif

             <!-- Alasan ditolak(jika status "ditolak") -->
             <td style="text-align: center;">
                @if($p->status === 'ditolak')
                    <div style="color: red">{{ $p->alasan_ditolak }}</div>
                @else
                    -
                @endif
             </td>

             <!-- Tanggal dipinjam/setujui,dikembalikan,ditolak,menunggu -->
            <td style="text-align: center;">
                @if ($p->status === 'dipinjam')
                    {{ $p->tanggal_disetujui->timezone('Asia/Jakarta')->translatedFormat('d F Y (H:i:s)') }}
                @elseif ($p->status === 'menunggu')
                    {{ $p->tanggal_pinjam->timezone('Asia/Jakarta')->translatedFormat('d F Y (H:i:s)') }}
                @else
                    {{ $p->tanggal_kembali->timezone('Asia/Jakarta')->translatedFormat('d F Y (H:i:s)') }}
                @endif
            </td>
        </tr>
            @endforeach
        @endforeach
    </tbody>
</table>

<br><br>

<table width="100%">
    <tr>
        <td width="70%"></td>
        <td align="center">
            <p>Petugas</p>
            <br><br><br>
            <p><b>@if(session('user'))
    <b>{{ session('user')->nama_lengkap }}</b>
@else
    <b>-</b>
@endif
</b></p>
        </td>
    </tr>
</table>

</body>
</html>
