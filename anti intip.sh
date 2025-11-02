#!/bin/bash

set -e

MERAH='\033[0;31m'
HIJAU='\033[0;32m'
KUNING='\033[1;33m'
BIRU='\033[0;34m'
UNGU='\033[0;35m'
NC='\033[0m'

# Fungsi pencatatan yang sederhana dan lancar
catatan() {
    gema -e "${GREEN}✓${NC} $1"
}

memperingatkan() {
    gema -e "${KUNING}!${NC} $1"
}

kesalahan() {
    gema -e "${RED}✗${NC} $1"
    keluar 1
}

informasi() {
    gema -e "${BLUE}>${NC} $1"
}

proses() {
    gema -e "${BLUE}→${NC} $1"
}

info_lisensi() {
    gema -e "${UNGU}♠${NC} $1"
}

info_rute() {
    gema -e "${GREEN}✓${NC} $1"
}

# Fungsi bilah pemuatan
tampilkan_pemuatan() {
    teks lokal=$1
    durasi lokal=2
    langkah lokal=20
    durasi langkah lokal=$(echo "skala=3; $durasi/$langkah" | bc)
    
    printf " ${teks} ["
    untuk ((i=0; i<langkah; i++)); lakukan
        printf "▰"
        tidur $step_duration
    Selesai
    printf "] Selesai!\n"
}

# Verifikasi lisensi
verifikasi_lisensi() {
    gema
    license_info "Verifikasi Lisensi"
    gema "======================"
    gema
    baca -p "Masukkan kunci lisensi: " kunci_lisensi
    
    jika [ -z "$license_key" ]; maka
        kesalahan "Kunci lisensi tidak boleh kosong!"
    fi
    
    # Verifikasi lisensi sederhana (sagaofficial)
    jika [ "$license_key" != "sagadev" ]; maka
        kesalahan "Kunci lisensi tidak valid! Akses ditolak."
    fi
    
    show_loading "Memverifikasi lisensi"
    log "Lisensi berhasil diverifikasi!"
    gema
    license_info "Dilisensikan kepada: @saga011212"
    license_info "Berlaku untuk: Middleware Keamanan Kustom"
    license_info "Jenis: Lisensi Domain Tunggal"
    gema
}

tampilkan_menu() {
    jernih
    kucing <<'EOF'
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠄⠒⠒⠉⣩⣽⣿⣿⣿⣿⣿⠿⢿⣶⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⠿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠉⠻⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣴⣶⣿⣿⣿⣿⣦⣄⣾⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⠏⠉⢹⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣁⡀⠀⢸⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣷⠀⢸⣿⣿⡇⠻⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣿⣿⣷⣼⣿⣿⡇⠀⠈⠻⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⡃⠙⣿⣿⣄⡀⠀⠈⠙⢷⣄⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠺⣿⣿⣿⣿⣿⣿⣿⡟⠁⠀⠘⣿⣿⣿⣷⣶⣤⣈⡟⢳⢄⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⢻⣿⣯⡉⠛⠻⢿⣿⣷⣧⡀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⡿⠹⣿⣿⣿⣷⠀⠀⠀⢀⣿⣿⣷⣄⠀⠀⠈⠙⠿⣿⣄⠀⠀⠀⢠⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⠋⠀⣀⣻⣿⣿⣿⣀⣠⣶⣿⣿⣿⣿⣿⣿⣷⣄⠀⠀⠀⠈⢹⠇⠀⠀⣾⣿⣿⣿⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣷⣿⣿⣿⣿⣿⣿⣿⣟⠛⠋⠉⠁⠀⠀⠀⠉⠻⢧⠀⠀⠀⠘⠃⠀⣼⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢢⡀⠀⠀⠀⠀⢿⣿⣿⠿⠟⠛⠉⠁⠈⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⢺⠀⠀⠀⠀⢀⣾⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠀⠊⠀⠀⠀⣰⣿⣿⣿⣿⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢷⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⣷⣤⣀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⠀⠀⠀⠀⠀⠀⠀⣀⣤⣶⣿⣿⣿⡿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠿⣿⣶⣦⣤⣤⣀⣀⣀⣻⣿⣀⣀⣤⣴⣶⣿⣿⣿⣿⣿⠿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡧⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
EOF

    gema
    gema "=========================================="
    gema "Opsi Sederhana"
    echo " Pemasang Middleware Keamanan Kustom"
    gema " @saga011212 "
    gema "=========================================="
    gema
    echo "Pilih opsi Menu:"
    echo "[1] Instal Middleware Keamanan"
    echo "[2] Menerapkan Rute"
    echo "[3] Pesan Kesalahan Kustom"
    echo "[4] Keamanan Jelas (Copot Pemasangan)"
    gema "[5] Segarkan Cache VPS"
    echo "[6] Hapus Semua Rute"
    echo "[7] Keluar"
    gema
}

tampilkan_lisensi() {
    gema
    license_info "Perjanjian Lisensi Perangkat Lunak"
    gema "=============================="
    gema
    echo "Produk: Middleware Keamanan Khusus untuk Pterodactyl"
    gema "Versi: 2.0"
    gema "Lisensi: sagaofficial"
    echo "Pengembang: @saga011212"
    gema
    echo "Persyaratan Lisensi:"
    echo "• Penggunaan domain tunggal"
    • Penggunaan pribadi dan komersial diperbolehkan
    echo "• Modifikasi diizinkan"
    echo "• Distribusi ulang tidak diizinkan"
    • Tidak ada garansi yang diberikan
    gema
    echo "Perangkat lunak ini dilindungi oleh kunci lisensi: sagaofficial"
    echo "Penggunaan tanpa izin dilarang."
    gema
}

mengembalikan_rute_default() {
    gema
    route_info "Pulihkan Rute Default"
    gema "========================"
    gema
    info "Ini akan mengembalikan rute admin.php dan api-client.php ke keadaan default"
    gema
    memperingatkan "Ini akan menghapus semua perlindungan middleware kustom dari rute!"
    gema
    baca -p "Apakah Anda yakin ingin mengembalikan rute default? (y/T): " konfirmasi
    
    jika [[ ! "$confirm" =~ ^[Yy]$ ]]; maka
        log "Pemulihan rute dibatalkan."
        kembali
    fi
    
    PTERO_DIR="/var/www/pterodactyl"
    
    jika [ ! -d "$PTERO_DIR" ]; maka
        kesalahan "Direktori Pterodactyl tidak ditemukan: $PTERO_DIR"
        kembali 1
    fi
    
    proses "Memulihkan rute default..."
    
    # 1. Pulihkan rute admin.php
    ADMIN_FILE="$PTERO_DIR/rute/admin.php"
    jika [ -f "$ADMIN_FILE" ]; maka
        proses "Memulihkan rute admin.php ke default..."
        
        # Metode 1: Hapus middleware keamanan khusus dengan berbagai pola
        jumlah_yang_dipulihkan=0
        
        # Pola 1: Pola middleware standar
        jika grep -q "middleware.*custom.security" "$ADMIN_FILE"; maka
            sed -i "s/->middleware(\['custom.security'\])//g" "$ADMIN_FILE"
            log "✓ Menghapus middleware keamanan kustom standar"
            ((jumlah_yang_dipulihkan++))
        fi
        
        # Pola 2: Middleware dengan kutipan berbeda
        jika grep -q "middleware.*custom.security" "$ADMIN_FILE"; maka
            sed -i "s/->middleware(\[\"custom.security\"\])//g" "$ADMIN_FILE"
            sed -i "s/->middleware(\['custom.security'\])//g" "$ADMIN_FILE"
            log "✓ Menghapus middleware keamanan khusus dengan tanda kutip berbeda"
            ((jumlah_yang_dipulihkan++))
        fi
        
        # Pola 3: Middleware dengan spasi
        jika grep -q "middleware.*custom.security" "$ADMIN_FILE"; maka
            sed -i "s/->middleware( \[ 'custom.security' \] )//g" "$ADMIN_FILE"
            sed -i "s/->middleware( \['custom.security'\] )//g" "$ADMIN_FILE"
            log "✓ Menghapus middleware keamanan khusus dengan spasi"
            ((jumlah_yang_dipulihkan++))
        fi
        
        # Pola 4: Beberapa array middleware
        jika grep -q "middleware.*custom.security" "$ADMIN_FILE"; maka
            # Hapus dari array middleware tunggal
            sed -i "s/->middleware(\['custom.security'\])//g" "$ADMIN_FILE"
            # Hapus dari beberapa array middleware
            sed -i "s/, 'custom.security'//g" "$ADMIN_FILE"
            sed -i "s/'custom.security', //g" "$ADMIN_FILE"
            log "✓ Menghapus custom.security dari beberapa array middleware"
            ((jumlah_yang_dipulihkan++))
        fi
        
        # Pembersihan akhir: Hapus array middleware yang kosong
        sed -i "s/->middleware(\[\])//g" "$ADMIN_FILE"
        sed -i "s/->middleware(\[ \])//g" "$ADMIN_FILE"
        
        # Verifikasi pemulihan
        jika grep -q "custom.security" "$ADMIN_FILE"; maka
            peringatan "⚠ Beberapa middleware keamanan khusus mungkin masih ada"
            proses "Pembersihan manual mungkin diperlukan"
        kalau tidak
            log "✓ Semua middleware keamanan khusus dihapus dari admin.php"
        fi
        
    kalau tidak
        peringatkan "admin.php tidak ditemukan: $ADMIN_FILE"
    fi
    
    # 2. Pulihkan rute api-client.php
    API_CLIENT_FILE="$PTERO_DIR/rute/api-client.php"
    jika [ -f "$API_CLIENT_FILE" ]; maka
        proses "Mengembalikan rute api-client.php ke default..."
        
        # Hapus custom.security dari grup rute /files dengan berbagai pola
        api_dipulihkan=0
        
        # Pola 1: Pola kelompok standar
        jika grep -q "prefix.*files.*middleware.*custom.security" "$API_CLIENT_FILE"; maka
            sed -i "s|Rute::grup(\['awalan' => '/berkas', 'middleware' => \['keamanan khusus'\]|Rute::grup(['awalan' => '/berkas'|g" "$API_CLIENT_FILE"
            sed -i "s|Rute::grup(['awalan' => '/file', 'middleware' => ['keamanan khusus']|Rute::grup(['awalan' => '/file'|g" "$API_CLIENT_FILE"
            log "✓ Mengembalikan grup rute /file ke default"
            ((api_dipulihkan++))
        fi
        
        # Pola 2: Hapus middleware individual dari rute
        jika grep -q "->middleware.*custom.security" "$API_CLIENT_FILE"; maka
            sed -i "s/->middleware(\['custom.security'\])//g" "$API_CLIENT_FILE"
            sed -i "s/->middleware(\[\"custom.security\"\])//g" "$API_CLIENT_FILE"
            log "✓ Menghapus middleware individual dari api-client.php"
            ((api_dipulihkan++))
        fi
        
        # Bersihkan array middleware yang kosong
        sed -i "s/->middleware(\[\])//g" "$API_CLIENT_FILE"
        sed -i "s/->middleware(\[ \])//g" "$API_CLIENT_FILE"
        
        jika [ "$api_restored" -eq 0 ]; maka
            peringatan "Tidak ada middleware khusus yang ditemukan di api-client.php"
        kalau tidak
            log "✓ rute api-client.php dipulihkan"
        fi
        
    kalau tidak
        peringatkan "api-client.php tidak ditemukan: $API_CLIENT_FILE"
    fi
    
    # 3. Hapus cache
    proses "Menghapus cache..."
    cd "$PTERO_DIR"
    sudo -u www-data php artisan config:clear
    sudo -u www-data php artisan route:clear
    sudo -u www-data php artisan view:clear
    sudo -u www-data php artisan cache:clear
    sudo -u www-data php artisan mengoptimalkan
    
    log "Cache dihapus"
    
    gema
    log "Pemulihan rute default berhasil diselesaikan!"
    gema
    info "Ringkasan:"
    log " • admin.php: Menghapus semua pola middleware keamanan khusus"
    log " • api-client.php: Grup rute dipulihkan dan middleware dihapus"
    log "• Semua cache dihapus"
    gema
    peringatan "Catatan: Jika rute masih bermasalah, verifikasi manual mungkin diperlukan"
}

clear_pterodactyl_cache() {
    gema
    route_info "Hapus Cache Pterodactyl"
    gema "============================="
    gema
    info "Ini akan menghapus semua cache Pterodactyl dan mengoptimalkan aplikasi"
    gema
    baca -p "Apakah Anda yakin ingin menghapus cache Pterodactyl? (y/T): " konfirmasi
    
    jika [[ ! "$confirm" =~ ^[Yy]$ ]]; maka
        log "Pembersihan cache dibatalkan."
        kembali
    fi
    
    PTERO_DIR="/var/www/pterodactyl"
    
    jika [ ! -d "$PTERO_DIR" ]; maka
        kesalahan "Direktori Pterodactyl tidak ditemukan: $PTERO_DIR"
        kembali 1
    fi
    
    proses "Membersihkan cache Pterodactyl..."
    
    # Hapus perintah cache
    cd "$PTERO_DIR"
    
    proses "Menghapus cache konfigurasi..."
    sudo -u www-data php artisan config:clear
    
    proses "Menghapus cache rute..."
    sudo -u www-data php artisan route:clear
    
    proses "Menghapus cache tampilan..."
    sudo -u www-data php artisan view:clear
    
    proses "Menghapus cache aplikasi..."
    sudo -u www-data php artisan cache:clear
    
    proses "Mengoptimalkan aplikasi..."
    sudo -u www-data php artisan mengoptimalkan
    
    log "✓ Semua cache berhasil dihapus!"
    gema
    log "Pembersihan cache selesai!"
}

clear_security() {
    gema
    info "Middleware Keamanan Jelas"
    gema "==========================="
    gema
    peringatan "Peringatan: Ini akan menghapus middleware keamanan dan mengembalikan sistem ke normal!"
    baca -p "Apakah Anda yakin ingin menghapus middleware keamanan? (y/T): " konfirmasi
    
    jika [[ ! "$confirm" =~ ^[Yy]$ ]]; maka
        log "Penghapusan dibatalkan."
        kembali
    fi
    
    PTERO_DIR="/var/www/pterodactyl"
    
    jika [ ! -d "$PTERO_DIR" ]; maka
        kesalahan "Direktori Pterodactyl tidak ditemukan: $PTERO_DIR"
    fi
    
    proses "Membersihkan middleware keamanan..."
    
    # 1. Hapus file middleware
    jika [ -f "$PTERO_DIR/app/Http/Middleware/CustomSecurityCheck.php" ]; maka
        rm -f "$PTERO_DIR/aplikasi/Http/Middleware/CustomSecurityCheck.php"
        log "File middleware dihapus"
    kalau tidak
        peringatan "File middleware tidak ditemukan"
    fi
    
    # 2. Hapus dari Kernel.php
    KERNEL_FILE="$PTERO_DIR/aplikasi/Http/Kernel.php"
    jika [ -f "$KERNEL_FILE" ]; maka
        jika grep -q "custom.security" "$KERNEL_FILE"; maka
            sed -i "/'custom.security' => \\\\Pterodactyl\\\\Http\\\\Middleware\\\\CustomSecurityCheck::class,/d" "$KERNEL_FILE"
            log "Middleware dihapus dari Kernel"
        kalau tidak
            peringatan "Middleware tidak terdaftar di Kernel"
        fi
    fi
    
    # 3. Hapus middleware dari rute
    proses "Membersihkan rute..."
    
    # api-client.php
    API_CLIENT_FILE="$PTERO_DIR/rute/api-client.php"
    jika [ -f "$API_CLIENT_FILE" ]; maka
        jika grep -q "Route::group(\['prefix' => '/files', 'middleware' => \['custom.security'\]" "$API_CLIENT_FILE"; maka
            sed -i "s/Rute::grup(\['awalan' => '\/berkas', 'middleware' => \['keamanan khusus'\]/Rute::grup(['awalan' => '\/berkas'/g" "$API_CLIENT_FILE"
            log "Middleware dihapus dari api-client.php"
        fi
    fi
    
    # admin.php - hapus middleware dari semua grup rute
    ADMIN_FILE="$PTERO_DIR/rute/admin.php"
    jika [ -f "$ADMIN_FILE" ]; maka
        # Pola 1: Hapus dari Route::group yang memiliki array middleware
        sed -i "s/, 'middleware' => \['custom.security'\]//g" "$ADMIN_FILE"
        
        # Pola 2: Hapus dari Route::group yang hanya memiliki middleware custom.security saja
        sed -i "s/'middleware' => \['custom.security'\], //g" "$ADMIN_FILE"
        sed -i "s/'middleware' => \['custom.security'\]//g" "$ADMIN_FILE"
        
        # Pola 3: Hapus dari rute individual
        sed -i "s/->middleware(\['custom.security'\])//g" "$ADMIN_FILE"
        
        # Pola 4: Bersihkan array middleware yang kosong jika ada
        sed -i "s/'middleware' => \[\],//g" "$ADMIN_FILE"
        sed -i "s/, 'middleware' => \[\]//g" "$ADMIN_FILE"
        
        log "Middleware dihapus dari admin.php"
    fi
    
    # 4. Hapus cache
    proses "Menghapus cache..."
    cd $PTERO_DIR
    sudo -u www-data php artisan config:clear
    sudo -u www-data php artisan route:clear
    sudo -u www-data php artisan view:clear
    sudo -u www-data php artisan cache:clear
    sudo -u www-data php artisan mengoptimalkan
    
    log "Cache dihapus"
    
    # 5. Mulai ulang layanan
    proses "Memulai ulang layanan..."
    
    PHP_SERVICE=""
    jika systemctl is-active --quiet php8.2-fpm; maka
        PHP_SERVICE="php8.2-fpm"
    elif systemctl is-active --quiet php8.1-fpm; lalu
        PHP_SERVICE="php8.1-fpm"
    elif systemctl is-active --quiet php8.0-fpm; lalu
        PHP_SERVICE="php8.0-fpm"
    elif systemctl is-active --quiet php8.3-fpm; lalu
        PHP_SERVICE="php8.3-fpm"
    fi
    
    jika [ -n "$PHP_SERVICE" ]; maka
        systemctl mulai ulang $PHP_SERVICE
        log "$PHP_SERVICE dimulai ulang"
    fi
    
    jika systemctl is-active --quiet pteroq; maka
        systemctl mulai ulang pteroq
        log "layanan pteroq dimulai ulang"
    fi
    
    jika systemctl is-active --quiet nginx; maka
        systemctl memuat ulang nginx
        log "nginx dimuat ulang"
    fi
    
    gema
    log "Middleware keamanan berhasil dihapus!"
    gema
    peringatan "Sistem sekarang dalam mode NORMAL tanpa perlindungan middleware keamanan"
}

tambahkan_middleware_keamanan_khusus() {
    gema
    route_info "Tambahkan Middleware Keamanan Kustom"
    gema "=================================="
    gema
    info "Ini akan menambahkan middleware 'custom.security' ke rute tertentu di admin.php dan api-client.php"
    gema
    baca -p "Apakah Anda yakin ingin menambahkan middleware keamanan khusus? (y/T): " konfirmasi
    
    jika [[ ! "$confirm" =~ ^[Yy]$ ]]; maka
        log "Penambahan middleware keamanan kustom dibatalkan."
        kembali
    fi
    
    PTERO_DIR="/var/www/pterodactyl"
    
    jika [ ! -d "$PTERO_DIR" ]; maka
        kesalahan "Direktori Pterodactyl tidak ditemukan: $PTERO_DIR"
        kembali 1
    fi
    
    ADMIN_FILE="$PTERO_DIR/rute/admin.php"
    API_CLIENT_FILE="$PTERO_DIR/rute/api-client.php"
    
    jika [ ! -f "$ADMIN_FILE" ]; maka
        kesalahan "admin.php tidak ditemukan: $ADMIN_FILE"
        kembali 1
    fi
    
    jika [ ! -f "$API_CLIENT_FILE" ]; maka
        kesalahan "api-client.php tidak ditemukan: $API_CLIENT_FILE"
        kembali 1
    fi
    
    proses "Menambahkan middleware keamanan khusus ke rute..."
    
    # Cadangkan file-file tersebut
    admin_backup="$ADMIN_FILE.backup.$(tanggal +%Y%m%d_%J%M%S)"
    api_backup="$API_CLIENT_FILE.backup.$(tanggal +%Y%m%d_%J%M%S)"
    cp "$ADMIN_FILE" "$admin_cadangan"
    cp "$API_CLIENT_FILE" "$api_cadangan"
    log "Cadangan dibuat: $admin_backup"
    log "Cadangan dibuat: $api_backup"
    
    # Penghitung untuk rute yang dimodifikasi
    jumlah_modifikasi=0
    
    # 1. Rute Admin.php
    proses "Memproses rute admin.php..."
    
    # 1.1 Grup pengaturan di admin.php
    jika grep -q "Route::group(\['prefix' => 'settings'\], function () {" "$ADMIN_FILE"; maka
        sed -i "s|Rute::grup(['awalan' => 'pengaturan'], fungsi () {|Rute::grup(['awalan' => 'pengaturan', 'middleware' => ['keamanan khusus']], fungsi () {|g" "$ADMIN_FILE"
        log "✓ Menambahkan middleware ke grup rute pengaturan"
        jumlah_yang_dimodifikasi=$((jumlah_yang_dimodifikasi + 1))
    kalau tidak
        peringatan "Pengaturan grup rute tidak ditemukan atau sudah dimodifikasi"
    fi
    
    # 1.2 Bagian Pengguna - Route::patch dan Route::delete
    proses "Memproses rute pengguna..."
    
    # Route::patch untuk pengguna
    jika grep -q "Route::patch('/view/{user:id}', \[Admin\\UserController::class, 'update'\]);" "$ADMIN_FILE"; maka
        sed -i "s|Route::patch('/view/{user:id}', \[Admin\\UserController::class, 'update'\]);|Route::patch('/view/{user:id}', \[Admin\\UserController::class, 'update'\])->middleware(['custom.security']);|g" "$ADMIN_FILE"
        log "✓ Menambahkan middleware ke Route::patch untuk pengguna"
        jumlah_yang_dimodifikasi=$((jumlah_yang_dimodifikasi + 1))
    kalau tidak
        peringatan "Route::patch untuk pengguna tidak ditemukan atau sudah dimodifikasi"
    fi
    
    # Route::delete untuk pengguna
    jika grep -q "Route::delete('/view/{user:id}', \[Admin\\UserController::class, 'delete'\]);" "$ADMIN_FILE"; maka
        sed -i "s|Rute::hapus('/tampilan/{id pengguna}', \[Admin\\PengontrolPengguna::kelas, 'hapus'\]);|Rute::hapus('/tampilan/{id pengguna}', \[Admin\\PengontrolPengguna::kelas, 'hapus'\])->middleware(['keamanan khusus']);|g" "$ADMIN_FILE"
        log "✓ Menambahkan middleware ke Route::delete untuk pengguna"
        jumlah_yang_dimodifikasi=$((jumlah_yang_dimodifikasi + 1))
    kalau tidak
        peringatan "Route::delete untuk pengguna yang tidak ditemukan atau sudah dimodifikasi"
    fi
    
    # 1.3 Bagian Server - Grup ServerInstalled
    proses "Memproses rute server..."
    
    # Route::get untuk detail server
    jika grep -q "Rute::dapatkan('/tampilan/{server:id}/detail', \[Admin\\Servers\\ServerViewController::kelas, 'detail'\])->nama('admin.servers.view.detail');" "$ADMIN_FILE"; maka
        sed -i "s|Rute::dapatkan('/tampilan/{server:id}/detail', \[Admin\\Servers\\ServerViewController::kelas, 'detail'\])->nama('admin.servers.tampilan.detail');|Rute::dapatkan('/tampilan/{server:id}/detail', \[Admin\\Servers\\ServerViewController::kelas, 'detail'\])->nama('admin.servers.tampilan.detail')->middleware(['keamanan khusus']);|g" "$ADMIN_FILE"
        log "✓ Menambahkan middleware ke rute detail server"
        jumlah_yang_dimodifikasi=$((jumlah_yang_dimodifikasi + 1))
    kalau tidak
        peringatan "Rute detail server tidak ditemukan atau sudah dimodifikasi"
    fi
    
    # Route::get untuk menghapus server
    jika grep -q "Rute::dapatkan('/tampilan/{server:id}/hapus', \[Admin\\Servers\\ServerViewController::kelas, 'hapus'\])->nama('admin.servers.tampilan.hapus');" "$ADMIN_FILE"; maka
        sed -i "s|Rute::dapatkan('/tampilan/{server:id}/hapus', \[Admin\\Servers\\ServerViewController::kelas, 'hapus'\])->nama('admin.servers.tampilan.hapus');|Rute::dapatkan('/tampilan/{server:id}/hapus', \[Admin\\Servers\\ServerViewController::kelas, 'hapus'\])->nama('admin.servers.tampilan.hapus')->middleware(['keamanan khusus']);|g" "$ADMIN_FILE"
        log "✓ Menambahkan middleware ke rute penghapusan server"
        jumlah_yang_dimodifikasi=$((jumlah_yang_dimodifikasi + 1))
    kalau tidak
        peringatan "Rute penghapusan server tidak ditemukan atau sudah dimodifikasi"
    fi

    # Route::post untuk menghapus server
    jika grep -q "Route::post('/view/{server:id}/delete', \[Admin\\ServersController::class, 'delete'\]);" "$ADMIN_FILE"; maka
        sed -i "s|Rute::post('/tampilan/{server:id}/hapus', \[Admin\\ServersController::kelas, 'hapus'\]);|Rute::post('/tampilan/{server:id}/hapus', \[Admin\\ServersController::kelas, 'hapus'\])->middleware(['keamanan khusus']);|g" "$ADMIN_FILE"
        log "✓ Menambahkan middleware ke rute penghapusan server"
        jumlah_yang_dimodifikasi=$((jumlah_yang_dimodifikasi + 1))
    kalau tidak
        peringatan "Rute penghapusan server tidak ditemukan atau sudah dimodifikasi"
    fi
    
    # Route::patch untuk pembaruan detail server
    jika grep -q "Route::patch('/view/{server:id}/details', \[Admin\\ServersController::class, 'setDetails'\]);" "$ADMIN_FILE"; maka
        sed -i "s|Rute::patch('/tampilan/{server:id}/detail', \[Admin\\ServersController::kelas, 'aturDetail'\]);|Rute::patch('/tampilan/{server:id}/detail', \[Admin\\ServersController::kelas, 'aturDetail'\])->middleware(['custom.security']);|g" "$ADMIN_FILE"
        log "✓ Menambahkan middleware ke rute pembaruan detail server"
        jumlah_yang_dimodifikasi=$((jumlah_yang_dimodifikasi + 1))
    kalau tidak
        peringatan "Rute pembaruan detail server tidak ditemukan atau sudah dimodifikasi"
    fi
    
    # Route::delete untuk menghapus basis data
    jika grep -q "Rute::hapus('/tampilan/{server:id}/basis data/{basis data:id}/hapus', \[Admin\\ServersController::kelas, 'hapusDatabase'\])->nama('admin.server.tampilan.basis data.hapus');" "$ADMIN_FILE"; maka
        sed -i "s|Rute::hapus('/tampilan/{server:id}/basis data/{basis data:id}/hapus', \[Admin\\ServersController::kelas, 'hapusDatabase'\])->nama('admin.servers.tampilan.basis data.hapus');|Rute::hapus('/tampilan/{server:id}/basis data/{basis data:id}/hapus', \[Admin\\ServersController::kelas, 'hapusDatabase'\])->nama('admin.servers.tampilan.basis data.hapus')->middleware(['keamanan khusus']);|g" "$ADMIN_FILE"
        log "✓ Menambahkan middleware ke rute penghapusan basis data"
        jumlah_yang_dimodifikasi=$((jumlah_yang_dimodifikasi + 1))
    kalau tidak
        peringatan "Rute penghapusan basis data tidak ditemukan atau sudah dimodifikasi"
    fi
    
    # 1.4 Bagian Node
    proses "Memproses rute node..."
    
    # Route::post untuk token pengaturan node
    jika grep -q "Rute::post('/view/{node:id}/settings/token', Admin\\NodeAutoDeployController::class)->name('admin.nodes.view.configuration.token');" "$ADMIN_FILE"; maka
        sed -i "s|Rute::post('/tampilan/{simpul:id}/pengaturan/token', Admin\\NodeAutoDeployController::kelas)->nama('admin.simpul.tampilan.konfigurasi.token');|Rute::post('/tampilan/{simpul:id}/pengaturan/token', Admin\\NodeAutoDeployController::kelas)->nama('admin.simpul.tampilan.konfigurasi.token')->middleware(['keamanan khusus']);|g" "$ADMIN_FILE"
        log "✓ Menambahkan middleware ke rute token pengaturan node"
        jumlah_yang_dimodifikasi=$((jumlah_yang_dimodifikasi + 1))
    kalau tidak
        peringatan "Rute token pengaturan node tidak ditemukan atau sudah dimodifikasi"
    fi
    
    # Route::patch untuk pengaturan node
    jika grep -q "Route::patch('/view/{node:id}/settings', \[Admin\\NodesController::class, 'updateSettings'\]);" "$ADMIN_FILE"; maka
        sed -i "s|Rute::patch('/tampilan/{simpul:id}/pengaturan', \[Admin\\NodesController::kelas, 'perbaruiPengaturan'\]);|Rute::patch('/tampilan/{simpul:id}/pengaturan', \[Admin\\NodesController::kelas, 'perbaruiPengaturan'\])->middleware(['keamanan khusus']);|g" "$ADMIN_FILE"
        log "✓ Menambahkan middleware ke rute pembaruan pengaturan node"
        jumlah_yang_dimodifikasi=$((jumlah_yang_dimodifikasi + 1))
    kalau tidak
        peringatan "Rute pembaruan pengaturan node tidak ditemukan atau sudah dimodifikasi"
    fi
    
    # Route::delete untuk menghapus node
    jika grep -q "Rute::hapus('/tampilan/{simpul:id}/hapus', \[Admin\\NodesController::kelas, 'hapus'\])->nama('admin.simpul.tampilan.hapus');" "$ADMIN_FILE"; maka
        sed -i "s|Rute::hapus('/tampilan/{simpul:id}/hapus', \[Admin\\NodesController::kelas, 'hapus'\])->nama('admin.simpul.tampilan.hapus');|Rute::hapus('/tampilan/{simpul:id}/hapus', \[Admin\\NodesController::kelas, 'hapus'\])->nama('admin.simpul.tampilan.hapus')->middleware(['keamanan khusus']);|g" "$ADMIN_FILE"
        log "✓ Menambahkan middleware ke rute penghapusan node"
        jumlah_yang_dimodifikasi=$((jumlah_yang_dimodifikasi + 1))
    kalau tidak
        peringatan "Rute penghapusan node tidak ditemukan atau sudah dimodifikasi"
    fi
    
    # 2. Rute Api-client.php
    proses "Memproses rute api-client.php..."
    
    # 2.1 Middleware grup server di api-client.php
    jika grep -q "Route::group(\[" "$API_CLIENT_FILE" dan grep -q "'prefix' => '/servers/{server}'" "$API_CLIENT_FILE" dan grep -q "ServerSubject::class" "$API_CLIENT_FILE"; maka
        # Temukan baris dengan array middleware dan tambahkan custom.security
        sed -i "/'middleware' => \[/,/\]/{
            /ResourceBelongsToServer::class,/a\ 'keamanan khusus',
        }" "$API_CLIENT_FILE"
        log "✓ Menambahkan custom.security ke middleware grup server"
        jumlah_yang_dimodifikasi=$((jumlah_yang_dimodifikasi + 1))
    kalau tidak
        peringatan "Rute grup server tidak ditemukan atau sudah dimodifikasi"
    fi
    
    # 2.2 Grup file di api-client.php
    jika grep -q "Route::group(\['prefix' => '/files'\], fungsi () {" "$API_CLIENT_FILE"; maka
        sed -i "s|Rute::grup(['awalan' => '/file'], fungsi () {|Rute::grup(['awalan' => '/file', 'middleware' => ['keamanan khusus']], fungsi () {|g" "$API_CLIENT_FILE"
        log "✓ Menambahkan middleware ke grup rute file"
        jumlah_yang_dimodifikasi=$((jumlah_yang_dimodifikasi + 1))
    kalau tidak
        peringatan "Grup rute file tidak ditemukan atau sudah dimodifikasi"
    fi
    
    # 3. Metode alternatif untuk rute yang mungkin memiliki format berbeda
    proses "Memeriksa format rute alternatif..."
    
    # Pola alternatif untuk rute yang sama
    pola_alternatif=(
        "Rute::patch.*tampilan/{pengguna:id}.*Admin.*PengontrolPengguna.*perbarui.*);"
        "Rute::hapus.*tampilan/{pengguna:id}.*Admin.*PengontrolPengguna.*hapus.*);"
        "Rute::dapatkan.*tampilan/{server:id}/detail.*Admin.*Server.*ServerViewController.*detail.*);"
        "Rute::dapatkan.*tampilan/{server:id}/hapus.*Admin.*Server.*ServerViewController.*hapus.*);"
        "Rute::post.*tampilan/{server:id}/hapus.*Admin.*PengontrolServer.*hapus.*);"
        "Rute::patch.*tampilan/{server:id}/detail.*Admin.*ServersController.*setDetail.*);"
        "Rute::hapus.*tampilan/{server:id}/basis data/{basis data:id}/hapus.*Admin.*Pengontrol Server.*hapus Basis Data.*);"
        "Rute::post.*tampilan/{simpul:id}/pengaturan/token.*Admin.*NodeAutoDeployController.*);"
        "Rute::patch.*tampilan/{simpul:id}/pengaturan.*Admin.*PengontrolNode.*perbaruiPengaturan.*);"
        "Rute::hapus.*tampilan/{simpul:id}/hapus.*Admin.*PengontrolNode.*hapus.*);"
    )
    
    untuk pola di "${alternative_patterns[@]}"; lakukan
        sementara IFS= baca -r baris; lakukan
            jika [ -n "$line" ] dan ! echo "$line" | grep -q "middleware"; maka
                # Tambahkan middleware dengan benar sebelum penutupan );
                baris_baru="${line%);})->middleware(['custom.security']);"
                
                # Melarikan diri untuk sed
                garis_yang_lolos=$(printf '%s\n' "$line" | sed 's/[[\.*^$/]/\\&/g')
                lolos_baris_baru=$(printf '%s\n' "$baris_baru" | sed 's/[[\.*^$/]/\\&/g')
                
                # Ganti dalam file
                jika sed -i "s|$escaped_line|$escaped_new_line|g" "$ADMIN_FILE"; maka
                    nama_rute=$(echo "$line" | awk '{print $2}')
                    log "✓ Menambahkan middleware ke $route_name"
                    jumlah_yang_dimodifikasi=$((jumlah_yang_dimodifikasi + 1))
                fi
            fi
        selesai < <(grep "$pattern" "$ADMIN_FILE" 2>/dev/null)
    Selesai
    
    # 4. Verifikasi perubahan
    proses "Memverifikasi perubahan..."
    jumlah_admin=$(grep -c ")->middleware(\['custom.security'\])" "$ADMIN_FILE" 2>/dev/null || echo "0")
    jumlah_api=$(grep -c "'custom.security'" "$API_CLIENT_FILE" 2>/dev/null || echo "0")
    jumlah_total=$((jumlah_admin + jumlah_api))
    
    # Hapus cache
    proses "Menghapus cache..."
    cd "$PTERO_DIR"
    sudo -u www-data php artisan config:clear
    sudo -u www-data php artisan route:clear
    sudo -u www-data php artisan view:clear
    sudo -u www-data php artisan cache:clear
    sudo -u www-data php artisan mengoptimalkan
    
    log "Cache dihapus"
    
    gema
    jika [ "$total_count" -gt 0 ]; maka
        log "Penambahan middleware keamanan kustom berhasil diselesaikan!"
        route_info "Ringkasan:"
        log " • Total rute yang dimodifikasi: $modified_count"
        log " • rute admin.php dengan custom.security: $admin_count"
        log " • rute api-client.php dengan custom.security: $api_count"
        log " • Total rute yang dilindungi: $total_count"
        log "• Cache dibersihkan dan dioptimalkan"
    kalau tidak
        kesalahan "Gagal menambahkan middleware ke rute mana pun! Silakan periksa rute secara manual."
    fi
    
    gema
    peringatan "Catatan: Jika rute tidak ditemukan, rute tersebut mungkin sudah memiliki middleware atau memiliki format yang berbeda"
    log "Periksa file cadangan untuk file asli:"
    log " - $admin_backup"
    log " - $api_backup"
}

pesan_kesalahan_kustom() {
    gema
    info "Pesan Kesalahan Kustom"
    gema "===================="
    gema
    baca -p "Masukkan teks kesalahan khusus (contoh: 'Akses ditolak!'): " custom_error
    
    jika [ -z "$custom_error" ]; maka
        kesalahan "Teks kesalahan tidak boleh kosong!"
    fi
    
    gema
    proses "Memperbarui pesan kesalahan ke: '$custom_error'..."
    
    jika [ ! -f "$PTERO_DIR/app/Http/Middleware/CustomSecurityCheck.php" ]; maka
        kesalahan "Middleware tidak terpasang! Silakan pasang terlebih dahulu."
    fi
    
    sed -i "s/'error' => 'Mau ngapain hama wkwkwk - @luxzopicial'/'error' => '$custom_error'/g" "$PTERO_DIR/app/Http/Middleware/CustomSecurityCheck.php"
    
    log "Pesan kesalahan diperbarui menjadi: '$custom_error'"
    
    show_loading "Menghapus cache"
    cd $PTERO_DIR
    sudo -u www-data php artisan config:clear
    sudo -u www-data php artisan route:clear
    sudo -u www-data php artisan cache:clear
    
    gema
    log "Pesan kesalahan berhasil diperbarui!"
}

terapkan_rute_manual() {
    proses "Menerapkan middleware ke rute..."
    
    API_CLIENT_FILE="$PTERO_DIR/rute/api-client.php"
    jika [ -f "$API_CLIENT_FILE" ]; maka
        proses "Memproses api-client.php..."
        
        jika grep -q "Route::group(\['prefix' => '/files'" "$API_CLIENT_FILE"; maka
            jika ! grep -q "Route::group(\['prefix' => '/files', 'middleware' => \['custom.security'\]" "$API_CLIENT_FILE"; maka
                sed -i "s/Rute::grup(\['awalan' => '\/berkas'/Rute::grup(['awalan' => '\/berkas', 'middleware' => ['keamanan khusus']/g" "$API_CLIENT_FILE"
                log "Diterapkan ke grup /files di api-client.php"
            kalau tidak
                peringatan "Sudah diterapkan ke grup /files"
            fi
        kalau tidak
            peringatkan "grup /files tidak ditemukan di api-client.php"
        fi
    fi

    ADMIN_FILE="$PTERO_DIR/rute/admin.php"
    jika [ -f "$ADMIN_FILE" ]; maka
        proses "Memproses admin.php..."

        jika grep -q "Route::group(\['prefix' => '/settings'" "$ADMIN_FILE"; maka
            jika ! grep -q "Route::group(\['prefix' => '/settings', 'middleware' => \['custom.security'\]" "$ADMIN_FILE"; maka
                sed -i "s/Rute::grup(\['awalan' => '\/pengaturan'/Rute::grup(['awalan' => '\/pengaturan', 'middleware' => ['keamanan khusus']/g" "$ADMIN_FILE"
                log "Diterapkan ke grup /settings di admin.php"
            kalau tidak
                peringatan "Sudah diterapkan ke grup /pengaturan"
            fi
        kalau tidak
            peringatan "/settings group tidak ditemukan di admin.php"
        fi
        
        # Cadangkan file asli
        cp "$ADMIN_FILE" "$ADMIN_FILE.cadangan"
        
        # Metode 1: Pemrosesan baris demi baris secara manual
        log "Memproses rute baris demi baris..."
        
        # Susunan pola rute yang harus dilindungi
        rute_yang_harus_dilindungi=(
            # Rute server
            "Rute::dapatkan('/tampilkan/{server:id}/hapus'"
            "Rute::post('/tampilkan/{server:id}/hapus'"
            "Rute::patch('/tampilkan/{server:id}/detail'"
            "Rute::dapatkan('/tampilkan/{server:id}/detail'"
            
            # Rute pengguna
            "Rute::patch('/tampilan/{pengguna:id}'"
            "Rute::hapus('/tampilkan/{pengguna:id}'"
            
            # Rute simpul
            "Rute::dapatkan('/tampilkan/{simpul:id}/pengaturan'"
            "Rute::dapatkan('/tampilkan/{simpul:id}/konfigurasi'"
            "Rute::post('/tampilan/{simpul:id}/pengaturan/token'"
            "Rute::patch('/tampilan/{simpul:id}/pengaturan'"
            "Rute::hapus('/tampilkan/{simpul:id}/hapus'"
        )
        
        jumlah_dilindungi=0
        
        untuk route_pattern di "${routes_to_protect[@]}"; lakukan
            proses "Mencari: $route_pattern"
            
            # Temukan garis yang tepat dengan pola ini
            sementara IFS= baca -r baris; lakukan
                jika [[ "$line" == *"$route_pattern"* ]] dan [[ "$line" != *")->middleware"* ]]; maka
                    # Hapus spasi di akhir dan periksa apakah baris diakhiri dengan );
                    garis_bersih=$(echo "$line" | sed 's/[[:space:]]*$//')
                    
                    jika [[ "$clean_line" == *");" ]]; maka
                        # Ganti ); dengan )->middleware(['custom.security']);
                        baris_baru="${clean_line%);})->middleware(['custom.security']);"
                        
                        # Melarikan diri dari karakter khusus untuk sed
                        garis_yang_lolos=$(printf '%s\n' "$line" | sed 's/[[\.*^$/]/\\&/g')
                        lolos_baris_baru=$(printf '%s\n' "$baris_baru" | sed 's/[[\.*^$/]/\\&/g')
                        
                        # Ganti baris dalam file
                        jika sed -i "s|$escaped_line|$escaped_new_line|g" "$ADMIN_FILE"; maka
                            log "✓ Dilindungi: $(echo "$line" | tr -s ' ' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
                            ((jumlah_dilindungi++))
                        kalau tidak
                            peringatkan "Gagal melindungi: $(echo "$line" | tr -s ' ' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
                        fi
                    kalau tidak
                        peringatkan "Baris tidak diakhiri dengan ); : $(echo "$line" | tr -s ' ' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
                    fi
                fi
            selesai < "$ADMIN_FILE"
        Selesai
        
        # Metode 2: Verifikasi perubahan telah diterapkan
        log "Memverifikasi aplikasi middleware..."
        verifikasi_jumlah=$(grep -c ")->middleware(\['custom.security'\])" "$ADMIN_FILE" || benar)
        
        jika [ $verify_count -gt 0 ]; maka
            log "Berhasil menerapkan middleware ke rute $verify_count"
        kalau tidak
            peringatan "Tidak ada middleware yang diterapkan! Menggunakan metode fallback..."
            
            # Metode fallback - penggantian string manual
            proses "Menggunakan penggantian string fallback..."
            
            # Tentukan pasangan pengganti
            penggantian=(
                # Rute server
                "Rute::dapatkan('/tampilan/{server:id}/hapus', [Admin\\Servers\\ServerViewController::kelas, 'hapus'])->nama('admin.servers.view.hapus');|Rute::dapatkan('/tampilan/{server:id}/hapus', [Admin\\Servers\\ServerViewController::kelas, 'hapus'])->nama('admin.servers.view.hapus')->middleware(['custom.security']);"
                "Rute::post('/tampilkan/{server:id}/hapus', [Admin\\ServersController::class, 'hapus']);|Rute::post('/tampilkan/{server:id}/hapus', [Admin\\ServersController::class, 'hapus'])->middleware(['custom.security']);"
                "Rute::patch('/tampilan/{server:id}/detail', [Admin\\ServersController::kelas, 'setDetail']);|Rute::patch('/tampilan/{server:id}/detail', [Admin\\ServersController::kelas, 'setDetail'])->middleware(['custom.security']);"
                "Rute::dapatkan('/tampilan/{server:id}/detail', [Admin\\Servers\\ServerViewController::kelas, 'detail'])->nama('admin.servers.tampilan.detail');|Rute::dapatkan('/tampilan/{server:id}/detail', [Admin\\Servers\\ServerViewController::kelas, 'detail'])->nama('admin.servers.tampilan.detail')->middleware(['keamanan khusus']);"
                
                # Rute pengguna
                "Rute::patch('/tampilkan/{id pengguna}', [Admin\\Pengendali Pengguna::kelas, 'perbarui']);|Rute::patch('/tampilkan/{id pengguna}', [Admin\\Pengendali Pengguna::kelas, 'perbarui'])->middleware(['keamanan khusus']);"
                "Rute::hapus('/tampilan/{id pengguna}', [Admin\\Pengendali Pengguna::kelas, 'hapus']);|Rute::hapus('/tampilan/{id pengguna}', [Admin\\Pengendali Pengguna::kelas, 'hapus'])->middleware(['keamanan khusus']);"
                
                # Rute simpul
                "Rute::dapatkan('/tampilan/{simpul:id}/pengaturan', [Admin\\Nodes\\NodeViewController::kelas, 'pengaturan'])->nama('admin.nodes.view.pengaturan');|Rute::dapatkan('/tampilan/{simpul:id}/pengaturan', [Admin\\Nodes\\NodeViewController::kelas, 'pengaturan'])->nama('admin.nodes.view.pengaturan')->middleware(['keamanan khusus']);"
                "Rute::dapatkan('/tampilan/{simpul:id}/konfigurasi', [Admin\\Nodes\\NodeViewController::kelas, 'konfigurasi'])->nama('admin.nodes.view.konfigurasi');|Rute::dapatkan('/tampilan/{simpul:id}/konfigurasi', [Admin\\Nodes\\NodeViewController::kelas, 'konfigurasi'])->nama('admin.nodes.view.konfigurasi')->middleware(['keamanan khusus']);"
                "Rute::post('/view/{node:id}/settings/token', Admin\\NodeAutoDeployController::class)->nama('admin.nodes.view.configuration.token');|Rute::post('/view/{node:id}/settings/token', Admin\\NodeAutoDeployController::class)->nama('admin.nodes.view.configuration.token')->middleware(['custom.security']);"
                "Rute::patch('/tampilan/{simpul:id}/pengaturan', [Admin\\NodesController::kelas, 'perbaruiPengaturan']);|Rute::patch('/tampilan/{simpul:id}/pengaturan', [Admin\\NodesController::kelas, 'perbaruiPengaturan'])->middleware(['keamanan khusus']);"
                "Rute::hapus('/tampilan/{simpul:id}/hapus', [Admin\\NodesController::kelas, 'hapus'])->nama('admin.simpul.tampilan.hapus');|Rute::hapus('/tampilan/{simpul:id}/hapus', [Admin\\NodesController::kelas, 'hapus'])->nama('admin.simpul.tampilan.hapus')->middleware(['keamanan.kustom']);"
            )
            
            jumlah_fallback=0
            untuk penggantian di "${replacements[@]}"; lakukan
                asli=$(echo "$pengganti" | potong -d'|' -f1)
                baru=$(echo "$penggantian" | potong -d'|' -f2)
                
                # Melarikan diri dari karakter khusus
                lolos_asli=$(printf '%s\n' "$asli" | sed 's/[[\.*^$/]/\\&/g')
                lolos_baru=$(printf '%s\n' "$baru" | sed 's/[[\.*^$/]/\\&/g')
                
                jika grep -q "$original" "$ADMIN_FILE"; maka
                    jika sed -i "s|$escaped_original|$escaped_new|g" "$ADMIN_FILE"; maka
                        log "✓ Perlindungan fallback: $(echo "$original" | cut -d'(' -f1)"
                        ((jumlah_fallback++))
                    fi
                fi
            Selesai
            
            jika [ $fallback_count -gt 0 ]; maka
                log "Metode fallback diterapkan middleware ke rute $fallback_count"
            kalau tidak
                kesalahan "Gagal menerapkan middleware ke rute mana pun!"
            fi
        fi
        
        # Verifikasi akhir
        jumlah_akhir=$(grep -c ")->middleware(\['custom.security'\])" "$ADMIN_FILE" || benar)
        log "Verifikasi akhir: $final_count rute dilindungi dengan middleware"
        
    kalau tidak
        kesalahan "File rute admin tidak ditemukan: $ADMIN_FILE"
    fi
    
    log "Perlindungan rute selesai"
}

add_routes_protection() {
    gema
    route_info "Tambahkan Perlindungan Rute"
    gema "========================"
    gema
    info "Ini akan menambahkan perlindungan middleware ke rute tertentu di admin.php dan api-client.php"
    gema
    baca -p "Apakah Anda yakin ingin menambahkan perlindungan rute? (y/T): " konfirmasi
    
    jika [[ ! "$confirm" =~ ^[Yy]$ ]]; maka
        log "Perlindungan rute dibatalkan."
        kembali
    fi
    
    PTERO_DIR="/var/www/pterodactyl"
    
    jika [ ! -d "$PTERO_DIR" ]; maka
        kesalahan "Direktori Pterodactyl tidak ditemukan: $PTERO_DIR"
        kembali 1
    fi
    
    proses "Menambahkan perlindungan rute..."
    
    # 1. Lindungi rute admin.php
    ADMIN_FILE="$PTERO_DIR/rute/admin.php"
    jika [ -f "$ADMIN_FILE" ]; maka
        proses "Melindungi rute admin.php..."
        
        # Cadangkan file tersebut
        cp "$ADMIN_FILE" "$ADMIN_FILE.cadangan"
        
        # Metode 1: Pencarian dan penggantian manual untuk rute tertentu
        proses "Mencari rute server tertentu..."
        
        # Tentukan pola rute yang tepat untuk mencari
        rute_yang_harus_dilindungi=(
            # Rute penghapusan server
            "Rute::dapatkan('/tampilkan/{server:id}/hapus', [Admin\\Servers\\ServerViewController::kelas, 'hapus'])->nama('admin.servers.tampilkan.hapus');"
            "Rute::post('/tampilan/{server:id}/hapus', [Admin\\ServersController::kelas, 'hapus']);"
            "Rute::patch('/tampilan/{server:id}/detail', [Admin\\ServersController::kelas, 'setDetail']);"
            
            # Rute detail server di grup ServerInstalled
            "Rute::dapatkan('/tampilan/{server:id}/detail', [Admin\\Servers\\ServerViewController::kelas, 'detail'])->nama('admin.servers.view.detail');"
            
            # Rute pengguna
            "Rute::patch('/tampilan/{pengguna:id}', [Admin\\UserController::kelas, 'perbarui']);"
            "Rute::hapus('/tampilan/{pengguna:id}', [Admin\\PengontrolPengguna::kelas, 'hapus']);"
            
            # Rute simpul
            "Rute::dapatkan('/tampilan/{simpul:id}/pengaturan', [Admin\\Nodes\\NodeViewController::kelas, 'pengaturan'])->nama('admin.nodes.view.pengaturan');"
            "Rute::dapatkan('/tampilan/{simpul:id}/konfigurasi', [Admin\\Node\\NodeViewController::kelas, 'konfigurasi'])->nama('admin.nodes.view.konfigurasi');"
            "Rute::post('/tampilan/{simpul:id}/pengaturan/token', Admin\\NodeAutoDeployController::kelas)->nama('admin.nodes.view.konfigurasi.token');"
            "Rute::patch('/tampilan/{simpul:id}/pengaturan', [Admin\\NodesController::kelas, 'perbaruiPengaturan']);"
            "Rute::hapus('/tampilan/{simpul:id}/hapus', [Admin\\NodesController::kelas, 'hapus'])->nama('admin.simpul.tampilan.hapus');"
        )
        
        jumlah_dilindungi=0
        
        untuk route_pattern di "${routes_to_protect[@]}"; lakukan
            nama_rute=$(echo "$pola_rute" | potong -d'(' -f1)
            proses "Memproses: $nama_rute"
            
            # Periksa apakah rute ada dalam file
            jika grep -qF "$route_pattern" "$ADMIN_FILE"; maka
                # Periksa apakah rute sudah memiliki middleware
                jika grep -F "$route_pattern" "$ADMIN_FILE" | grep -q "middleware"; maka
                    peringatkan "⚠ Sudah dilindungi: $route_name"
                kalau tidak
                    # Buat rute baru dengan middleware
                    rute_baru="${pola_rute%);}->middleware(['keamanan_khusus']);"
                    
                    # Melarikan diri dari karakter khusus untuk sed
                    pola_lolos=$(printf '%s\n' "$pola_rute" | sed 's/[[\.*^$/]/\\&/g')
                    lolos_rute_baru=$(printf '%s\n' "$rute_baru" | sed 's/[[\.*^$/]/\\&/g')
                    
                    # Ganti dalam file
                    jika sed -i "s|$escaped_pattern|$escaped_new_route|g" "$ADMIN_FILE"; maka
                        log "✓ Dilindungi: $route_name"
                        jumlah_yang_dilindungi=$((jumlah_yang_dilindungi + 1))
                    kalau tidak
                        peringatkan "✗ Gagal melindungi: $route_name"
                    fi
                fi
            kalau tidak
                peringatkan "⚠ Rute tidak ditemukan: $route_name"
            fi
        Selesai
        
        # Metode 2: Debug - menunjukkan rute apa yang sebenarnya ada
        proses "Debug: Memeriksa rute aktual dalam file..."
        
        rute_debug=(
            "lihat/{server:id}/hapus"
            "lihat/{server:id}/detail"
            "lihat/{pengguna:id}"
            "tampilkan/{simpul:id}/pengaturan"
            "tampilkan/{simpul:id}/konfigurasi"
            "tampilkan/{simpul:id}/pengaturan/token"
            "lihat/{simpul:id}/hapus"
        )
        
        untuk debug_route di "${debug_routes[@]}"; lakukan
            jika grep -n "Route::.*$debug_route" "$ADMIN_FILE" >/dev/null 2>&1; maka
                log "Ditemukan: $debug_route"
            kalau tidak
                peringatkan "Tidak ditemukan: $debug_route"
            fi
        Selesai
        
        # Metode 3: Pendekatan alternatif - pemrosesan baris demi baris
        proses "Menggunakan pendekatan baris demi baris alternatif..."
        
        # Buat file sementara untuk diproses
        BERKAS_TEMP=$(mktemp)
        cp "$ADMIN_FILE" "$TEMP_FILE"
        
        # Tentukan pola rute yang cocok (tanpa baris lengkap)
        pola_rute_pendek=(
            "Rute::dapatkan.*tampilan/{server:id}/hapus"
            "Rute::post.*tampilan/{server:id}/hapus"
            "Rute::patch.*tampilan/{server:id}/detail"
            "Rute::dapatkan.*tampilan/{server:id}/detail"
            "Rute::patch.*tampilan/{pengguna:id}"
            "Rute::hapus.*tampilan/{pengguna:id}"
            "Rute::dapatkan.*tampilan/{simpul:id}/pengaturan"
            "Rute::dapatkan.*tampilan/{simpul:id}/konfigurasi"
            "Rute::post.*tampilan/{simpul:id}/pengaturan/token"
            "Rute::patch.*tampilan/{simpul:id}/pengaturan"
            "Rute::hapus.*tampilan/{simpul:id}/hapus"
        )
        
        alt_dilindungi=0
        untuk pola di "${route_patterns_short[@]}"; lakukan
            # Temukan baris yang cocok dengan pola yang tidak memiliki middleware
            sementara IFS= baca -r baris; lakukan
                # Lewati baris kosong
                [ -z "$line" ] dan lanjutkan
                
                # Periksa apakah baris cocok dengan pola dan tidak memiliki middleware
                jika echo "$line" | grep -q "$pattern" dan ! echo "$line" | grep -q "middleware"; maka
                    # Periksa apakah baris diakhiri dengan );
                    jika echo "$line" | grep -q ");$"; maka
                        # Hapus ); dan tambahkan middleware
                        baris_baru="${line%);}->middleware(['custom.security']);"
                        
                        # Melarikan diri untuk sed
                        garis_yang_lolos=$(printf '%s\n' "$line" | sed 's/[[\.*^$/]/\\&/g')
                        lolos_baris_baru=$(printf '%s\n' "$baris_baru" | sed 's/[[\.*^$/]/\\&/g')
                        
                        # Ganti di file temp
                        jika sed -i "s|$escaped_line|$escaped_new_line|g" "$TEMP_FILE"; maka
                            nama_rute_alt=$(echo "$line" | cut -d'(' -f1 | tr -s ' ')
                            log "✓ Alt dilindungi: $route_name_alt"
                            alt_dilindungi=$((alt_dilindungi + 1))
                        fi
                    fi
                fi
            selesai < <(grep -n "$pattern" "$ADMIN_FILE" 2>/dev/null | potong -d: -f2-)
        Selesai
        
        # Jika metode alternatif menemukan rute, salin kembali file temp
        jika [ -n "$alt_protected" ] dan [ "$alt_protected" -gt 0 ]; maka
            cp "$TEMP_FILE" "$ADMIN_FILE"
            log "Metode alternatif melindungi rute $alt_protected"
        fi
        
        # Bersihkan
        rm -f "$TEMP_FILE"
        
        # Metode 4: Verifikasi akhir
        proses "Verifikasi akhir..."
        jumlah_akhir=$(grep -c "->middleware(\['custom.security'\])" "$ADMIN_FILE" 2>/dev/null || echo "0")
        
        jika [ -n "$final_count" ] dan [ "$final_count" -gt 0 ]; maka
            log "Berhasil melindungi rute $final_count dengan middleware"
        kalau tidak
            kesalahan "Gagal melindungi rute apa pun! Harap periksa rute secara manual."
        fi
        
    kalau tidak
        peringatkan "admin.php tidak ditemukan: $ADMIN_FILE"
    fi
    
    # 2. Lindungi rute api-client.php
    API_CLIENT_FILE="$PTERO_DIR/rute/api-client.php"
    jika [ -f "$API_CLIENT_FILE" ]; maka
        proses "Melindungi rute api-client.php..."
        
        # Cadangkan file tersebut
        cp "$API_CLIENT_FILE" "$API_CLIENT_FILE.cadangan"
        
        # Lindungi grup rute /files
        jika grep -q "Route::group(\['prefix' => '/files'" "$API_CLIENT_FILE"; maka
            jika ! grep -q "Route::group(\['prefix' => '/files', 'middleware' => \['custom.security'\]" "$API_CLIENT_FILE"; maka
                sed -i "s|Rute::grup(\['awalan' => '/berkas'|Rute::grup(['awalan' => '/berkas', 'middleware' => ['keamanan khusus']|g" "$API_CLIENT_FILE"
                log "Grup rute /files yang dilindungi di api-client.php"
            kalau tidak
                peringatkan "/files grup rute sudah dilindungi"
            fi
        kalau tidak
            peringatkan "/files route group tidak ditemukan"
        fi
        
    kalau tidak
        peringatkan "api-client.php tidak ditemukan: $API_CLIENT_FILE"
    fi
    
    # 3. Hapus cache
    proses "Menghapus cache..."
    cd "$PTERO_DIR"
    sudo -u www-data php artisan config:clear
    sudo -u www-data php artisan route:clear
    sudo -u www-data php artisan cache:clear
    sudo -u www-data php artisan mengoptimalkan
    
    log "Cache dihapus"
    
    gema
    log "Perlindungan rute berhasil diselesaikan!"
    route_info "Ringkasan:"
    log " • Total rute yang dilindungi: ${final_count:-0}"
    log " • File dikelompokkan dilindungi di api-client.php"
    gema
    peringatan "Jika rute masih belum terlindungi, silakan periksa format rute yang tepat di admin.php"
    log "Anda dapat menambahkan ->middleware(['custom.security']) secara manual sebelum penutupan );"
}

instal_middleware() {
    jika [ "$EUID" -ne 0 ]; maka
        kesalahan "Silakan jalankan sebagai root: sudo bash <(curl -s https://raw.githubusercontent.com/iLyxxDev/hosting/main/security.sh)"
    fi

    # Verifikasi lisensi sebelum instalasi
    verifikasi_lisensi

    PTERO_DIR="/var/www/pterodactyl"

    jika [ ! -d "$PTERO_DIR" ]; maka
        kesalahan "Direktori Pterodactyl tidak ditemukan: $PTERO_DIR"
    fi

    proses "Memasang Middleware Keamanan Kustom untuk Pterodactyl..."
    log "Direktori Pterodactyl: $PTERO_DIR"

    jika [ ! -d "$PTERO_DIR/rute" ]; maka
        kesalahan "Direktori rute tidak ditemukan: $PTERO_DIR/rute"
    fi

    show_loading "Membuat file middleware"
    kucing > $PTERO_DIR/aplikasi/Http/Middleware/CustomSecurityCheck.php << 'EOF'
<?php

ruang nama Pterodactyl\Http\Middleware;

gunakan Penutupan;
gunakan Illuminate\Http\JsonResponse;
gunakan Illuminate\Http\RedirectResponse;
gunakan Illuminate\Http\Request;
gunakan Pterodactyl\Models\Server;
gunakan Pterodactyl\Models\User;
gunakan Pterodactyl\Models\Node;

kelas CustomSecurityCheck
{
    fungsi publik handle(Permintaan $permintaan, Penutupan $berikutnya)
    {
        jika (!$request->user()) {
            kembalikan $next($request);
        }

        $currentUser = $request->user();
        $path = $request->path();
        $metode = $permintaan->metode();

        jika ($currentUser->root_admin dan $this->isAdminAccessingRestrictedArea($path, $method)) {
            kembalikan JsonResponse baru([
                'error' => 'Mau ngapain hama wkwkwk - @saga011212'
            ], 403);
        }

        jika ($currentUser->root_admin dan $this->isAdminAccessingSettings($path, $method)) {
            kembalikan JsonResponse baru([
                'error' => 'Mau ngapain hama wkwkwk - @saga011212'
            ], 403);
        }

        jika ($currentUser->root_admin dan $this->isAdminModifyingUser($path, $method)) {
            kembalikan JsonResponse baru([
                'error' => 'Mau ngapain hama wkwkwk - @saga011212'
            ], 403);
        }

        jika ($currentUser->root_admin dan $this->isAdminModifyingServer($path, $method)) {
            kembalikan JsonResponse baru([
                'error' => 'Mau ngapain hama wkwkwk - @saga011212'
            ], 403);
        }

        jika ($currentUser->root_admin dan $this->isAdminModifyingNode($path, $method)) {
            kembalikan JsonResponse baru([
                'error' => 'Mau ngapain hama wkwkwk - @saga011212'
            ], 403);
        }

        jika ($currentUser->root_admin dan $this->isAdminDeletingViaAPI($path, $method)) {
            kembalikan JsonResponse baru([
                'error' => 'Mau ngapain hama wkwkwk - @saga011213'
            ], 403);
        }

        jika ($currentUser->root_admin dan $this->isAdminAccessingSettingsPanel($path, $method)) {
            kembalikan JsonResponse baru([
                'error' => 'Mau ngapain hama wkwkwk - @saga011212'
            ], 403);
        }

        jika ($currentUser->root_admin dan $this->isAdminAccessingNodeSettings($path, $method)) {
            kembalikan JsonResponse baru([
                'error' => 'Mau ngapain hama wkwkwk - @saga011212'
            ], 403);
        }

        $server = $request->route('server');
        jika ($server instanceof Server) {
            $isServerOwner = $currentUser->id === $server->owner_id;
            jika (!$isServerOwner) {
                kembalikan JsonResponse baru([
                    'error' => 'Mau ngapain hama wkwkwk - @saga011212'
                ], 403);
            }
        }

        jika (!$currentUser->root_admin) {
            $user = $request->route('pengguna');
            jika ($user instanceof Pengguna dan $currentUser->id !== $user->id) {
                kembalikan JsonResponse baru([
                    'error' => 'Mau ngapain hama wkwkwk - @saga011212'
                ], 403);
            }

            jika ($this->isAccessingRestrictedList($path, $method, $user)) {
                kembalikan JsonResponse baru([
                    'error' => 'Mau ngapain hama wkwkwk - @saga011212'
                ], 403);
            }
        }

        kembalikan $next($request);
    }

    fungsi pribadi isAdminAccessingRestrictedArea(string $path, string $method): bool
    {
        jika ($metode !== 'DAPATKAN') {
            kembalikan salah;
        }

        jika (str_contains($path, 'admin/api')) {
            kembalikan salah;
        }

        $jalurterbatas = [
            'admin/pengguna',
            'admin/server',
            'admin/simpul',
            'admin/basis data',
            'admin/lokasi',
            'admin/sarang',
            'admin/mount',
            'admin/telur',
            'admin/pengaturan',
            'admin/ikhtisar'
        ];

        foreach ($jalurterbatas sebagai $jalurterbatas) {
            jika (str_berisi($path, $restrictedPath)) {
                kembalikan benar;
            }
        }

        jika (str_dimulai_dengan($path, 'admin/') dan !str_berisi($path, 'admin/api')) {
            kembalikan benar;
        }

        kembalikan salah;
    }

    fungsi pribadi isAdminAccessingSettings(string $path, string $method): bool
    {
        jika (str_contains($path, 'admin/pengaturan')) {
            kembalikan benar;
        }

        jika (str_contains($path, 'aplikasi/pengaturan')) {
            kembalikan dalam_array($metode, ['POST', 'PUT', 'PATCH', 'HAPUS']);
        }

        kembalikan salah;
    }

    fungsi pribadi isAdminModifyingUser(string $path, string $method): bool
    {
        jika (str_contains($path, 'admin/pengguna')) {
            kembalikan dalam_array($metode, ['POST', 'PUT', 'PATCH', 'HAPUS']);
        }

        jika (str_contains($path, 'aplikasi/pengguna')) {
            kembalikan dalam_array($metode, ['POST', 'PUT', 'PATCH', 'HAPUS']);
        }

        kembalikan salah;
    }

    fungsi pribadi isAdminModifyingServer(string $path, string $method): bool
    {
        jika (str_contains($path, 'admin/server')) {
            jika ($metode === 'HAPUS') {
                kembalikan benar;
            }
            jika ($metode === 'POST' dan str_berisi($path, 'hapus')) {
                kembalikan benar;
            }
        }

        jika (str_contains($path, 'aplikasi/server')) {
            jika ($metode === 'HAPUS') {
                kembalikan benar;
            }
        }

        kembalikan salah;
    }

    fungsi pribadi isAdminModifyingNode(string $path, string $method): bool
    {
        jika (str_berisi($path, 'admin/node')) {
            kembalikan dalam_array($metode, ['POST', 'PUT', 'PATCH', 'HAPUS']);
        }

        jika (str_contains($path, 'aplikasi/simpul')) {
            kembalikan dalam_array($metode, ['POST', 'PUT', 'PATCH', 'HAPUS']);
        }

        kembalikan salah;
    }

    fungsi pribadi isAdminDeletingViaAPI(string $path, string $method): bool
    {
        jika ($metode === 'HAPUS' dan preg_match('#aplikasi/pengguna/\d+#', $path)) {
            kembalikan benar;
        }

        jika ($metode === 'HAPUS' dan preg_match('#aplikasi/server/\d+#', $path)) {
            kembalikan benar;
        }

        jika ($metode === 'HAPUS' dan preg_match('#aplikasi/server/\d+/.+#', $path)) {
            kembalikan benar;
        }

        kembalikan salah;
    }

    fungsi pribadi isAdminAccessingSettingsPanel(string $path, string $method): bool
    {
        jika ($metode !== 'DAPATKAN') {
            kembalikan salah;
        }

        JalurPanelPengaturan = [
            'admin/pengaturan/umum',
            'admin/pengaturan/email',
            'admin/pengaturan/lanjutan',
            'admin/pengaturan/keamanan',
            'admin/pengaturan/fitur',
            'admin/pengaturan/basis data',
            'admin/pengaturan/ui',
            'admin/pengaturan/tema'
        ];

        foreach ($settingsPanelPaths sebagai $settingsPath) {
            jika (str_berisi($path, $settingsPath)) {
                kembalikan benar;
            }
        }

        kembalikan salah;
    }

    fungsi pribadi isAdminAccessingNodeSettings(string $path, string $method): bool
    {
        jika ($metode !== 'DAPATKAN') {
            kembalikan salah;
        }

        JalurPengaturan $node = [
            'admin/simpul/tampilan/',
            'admin/simpul/pengaturan',
            'admin/node/konfigurasi',
            'admin/simpul/alokasi',
            'admin/simpul/server'
        ];

        foreach ($nodeSettingsPaths sebagai $nodePath) {
            jika (str_berisi($path, $nodePath)) {
                kembalikan benar;
            }
        }

        jika (preg_match('#admin/nodes/view/\d+/settings#', $path)) {
            kembalikan benar;
        }

        jika (preg_match('#admin/nodes/view/\d+/configuration#', $path)) {
            kembalikan benar;
        }

        kembalikan salah;
    }

    fungsi pribadi isAccessingRestrictedList(string $path, string $method, $user): bool
    {
        jika ($metode !== 'DAPATKAN' || $pengguna) {
            kembalikan salah;
        }

        $jalurterbatas = [
            'admin/pengguna', 'aplikasi/pengguna',
            'admin/server', 'aplikasi/server',
            'admin/node', 'aplikasi/node',
            'admin/basis data', 'admin/lokasi',
            'admin/sarang', 'admin/gunungan', 'admin/telur',
            'admin/pengaturan', 'aplikasi/pengaturan'
        ];

        foreach ($jalurterbatas sebagai $jalurterbatas) {
            jika (str_berisi($path, $restrictedPath)) {
                kembalikan benar;
            }
        }

        kembalikan salah;
    }
}
EOF

    log "File middleware dibuat"

    KERNEL_FILE="$PTERO_DIR/aplikasi/Http/Kernel.php"
    proses "Mendaftarkan middleware di Kernel..."

    jika grep -q "custom.security" "$KERNEL_FILE"; maka
        peringatan "Middleware sudah terdaftar di Kernel"
    kalau tidak
        sed -i "/dilindungi \$middlewareAliases = \[/a\\
        'custom.security' => \\\\Pterodactyl\\\\Http\\\\Middleware\\\\CustomSecurityCheck::class," "$KERNEL_FILE"
        log "Middleware terdaftar di Kernel"
    fi

    terapkan_rute_manual

    show_loading "Menghapus cache dan mengoptimalkan"
    cd $PTERO_DIR
    sudo -u www-data php artisan config:clear
    sudo -u www-data php artisan route:clear
    sudo -u www-data php artisan view:clear
    sudo -u www-data php artisan cache:clear
    sudo -u www-data php artisan mengoptimalkan

    log "Cache berhasil dibersihkan"

    proses "Memulai ulang layanan..."

    PHP_SERVICE=""
    jika systemctl is-active --quiet php8.2-fpm; maka
        PHP_SERVICE="php8.2-fpm"
    elif systemctl is-active --quiet php8.1-fpm; lalu
        PHP_SERVICE="php8.1-fpm"
    elif systemctl is-active --quiet php8.0-fpm; lalu
        PHP_SERVICE="php8.0-fpm"
    elif systemctl is-active --quiet php8.3-fpm; lalu
        PHP_SERVICE="php8.3-fpm"
    kalau tidak
        peringatan "Layanan PHP-FPM tidak terdeteksi, melewatkan restart"
    fi

    jika [ -n "$PHP_SERVICE" ]; maka
        systemctl mulai ulang $PHP_SERVICE
        log "$PHP_SERVICE dimulai ulang"
    fi

    jika systemctl is-active --quiet pteroq-service; maka
        systemctl memulai ulang layanan pteroq
        log "layanan pterodactyl dimulai ulang"
    fi

    jika systemctl is-active --quiet nginx; maka
        systemctl memuat ulang nginx
        log "nginx dimuat ulang"
    fi

    gema
    log "Middleware Keamanan Kustom berhasil diinstal!"
    gema
    info "Ringkasan Perlindungan:"
    log " • Admin hanya dapat mengakses: API Aplikasi (untuk Kunci API)"
    log "• Admin diblokir dari: Semua tab panel admin lainnya"
    log "• Operasi API DELETE diblokir"
    log "• Akses panel pengaturan diblokir"
    log "• Akses pengaturan node diblokir"
    log "• Perlindungan kepemilikan server aktif"
    log "• Pembatasan akses pengguna aktif"
    gema
    peringatan "Uji dengan masuk sebagai admin dan mengakses tab yang diblokir"
    log "Gunakan opsi 'Hapus Keamanan' untuk menghapus instalasi"
}

utama() {
    meskipun benar; lakukan
        tampilkan_menu
        baca -p "$(info 'Pilih opsi (1-7): ')" pilihan
        
        kasus $choice di
            1)
                gema
                instal_middleware
                ;;
            2)
                tambahkan_middleware_keamanan_khusus
                ;;
            3)
                pesan_kesalahan_kustom
                ;;
            4)
                keamanan_jelas
                ;;
            5)
                clear_pterodactyl_cache
                ;;
            6)
                pulihkan_rute_default
                ;;
            7)
                gema
                log "Terima kasih! Keluar dari program."
                keluar 0
                ;;
            *)
                kesalahan "Pilihan tidak valid! Pilih 1, 2, 3, 4, 5, atau 6."
                ;;
        esac
        
        gema
        baca -p "$(info 'Tekan Enter untuk melanjutkan...')"
    Selesai
}

utama