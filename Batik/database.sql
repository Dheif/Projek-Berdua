
CREATE DATABASE IF NOT EXISTS db_batiknusa;
USE db_batiknusa;

-- 1. Tabel Produk
CREATE TABLE produk (
    id_produk INT AUTO_INCREMENT PRIMARY KEY,
    nama_produk VARCHAR(100) NOT NULL,
    deskripsi TEXT,
    kategori VARCHAR(50) NOT NULL,
    ukuran VARCHAR(10) NOT NULL,
    warna VARCHAR(30),
    harga DECIMAL(12,2) NOT NULL,
    stok INT NOT NULL DEFAULT 0,
    foto VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 2. Tabel Pelanggan
CREATE TABLE pelanggan (
    id_pelanggan INT AUTO_INCREMENT PRIMARY KEY,
    nama_pelanggan VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    no_hp VARCHAR(20),
    alamat TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 3. Tabel Pesanan
CREATE TABLE pesanan (
    id_pesanan INT AUTO_INCREMENT PRIMARY KEY,
    id_pelanggan INT NOT NULL,
    tanggal_pesanan DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_harga DECIMAL(12,2) NOT NULL DEFAULT 0,
    alamat_pengiriman TEXT NOT NULL,
    metode_pembayaran VARCHAR(30) NOT NULL,
    status_pesanan ENUM(
        'Menunggu Pembayaran',
        'Diproses',
        'Dikirim',
        'Selesai',
        'Dibatalkan'
    ) DEFAULT 'Menunggu Pembayaran',

    FOREIGN KEY (id_pelanggan)
    REFERENCES pelanggan(id_pelanggan)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 4. Tabel Detail Pesanan
CREATE TABLE detail_pesanan (
    id_detail INT AUTO_INCREMENT PRIMARY KEY,
    id_pesanan INT NOT NULL,
    id_produk INT NOT NULL,
    jumlah INT NOT NULL,
    harga_satuan DECIMAL(12,2) NOT NULL,
    subtotal DECIMAL(12,2) NOT NULL,

    FOREIGN KEY (id_pesanan)
    REFERENCES pesanan(id_pesanan)
    ON UPDATE CASCADE
    ON DELETE CASCADE,

    FOREIGN KEY (id_produk)
    REFERENCES produk(id_produk)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;
