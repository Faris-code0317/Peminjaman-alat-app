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
            <p>Periode {{ $from->timezone('Asia/Jakarta')->translatedFormat('d F Y') }} s/d {{ $to->timezone('Asia/Jakarta')->translatedFormat('d F Y') }}</p>
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
            @if($showKategori)
                <th>Kategori Alat</th>
            @endif
            <th>Jumlah</th>
            <th>Status</th>
            @if($showTanggalMengajukan)
                <th>Tanggal Mengajukan</th>
            @endif
            @if($showTanggalDisetujui)
                <th>Tanggal Disetujui</th>
            @endif
            @if($showAlasan)
                <th>Alasan</th>
            @endif
            <th>Tanggal (Timeline)</th>
        </tr>
    </thead>
    <tbody>
        @php
            $peminjamanSorted = $peminjaman->sortByDesc(function ($p) {
                return match ($p->status) {
                    'menunggu' => $p->tanggal_pinjam,
                    'dipinjam' => $p->tanggal_disetujui,
                    default => $p->tanggal_kembali,
                };
            });
        @endphp
        @foreach($peminjamanSorted as $p)
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
            @if($showKategori)
                <td>{{ $d->alat->kategori->nama_kategori ?? '-' }}</td>
            @endif

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

            @if($showTanggalMengajukan)
                <td style="text-align: center;">
                    {{ $p->tanggal_pinjam->timezone('Asia/Jakarta')->translatedFormat('d F Y (H:i:s)') }}
                 </td>
            @endif

            @if($showTanggalDisetujui)
                <td style="text-align: center;">
                    @if ($p->status === 'dipinjam')
                        {{ $p->tanggal_disetujui->timezone('Asia/Jakarta')->translatedFormat('d F Y (H:i:s)') }}
                    @elseif ($p->status === 'dikembalikan')
                        {{ $p->tanggal_disetujui->timezone('Asia/Jakarta')->translatedFormat('d F Y (H:i:s)') }}
                    @else
                        -
                    @endif
                 </td>
            @endif

             <!-- Alasan ditolak(jika status "ditolak") -->
             @if($showAlasan)
                <td style="text-align: center;">
                    @if($p->status === 'ditolak')
                        <div style="color: red">{{ $p->alasan_ditolak }}</div>
                    @else
                        -
                    @endif
                 </td>
             @endif

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
