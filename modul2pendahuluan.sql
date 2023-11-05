CREATE DATABASE kopi_kedai_nuri;

-- 1. Membuat tabel dari PDM 

CREATE TABLE customer (
   ID_customer CHAR(6) PRIMARY KEY NOT NULL,
   nama_customer VARCHAR(100) NOT NULL
);

CREATE TABLE pegawai (
   NIK CHAR(16) PRIMARY KEY NOT NULL,
   nama_pegawai VARCHAR(100) NOT NULL,
   jenis_kelamin CHAR(1) NOT NULL,
   email VARCHAR(50) NOT NULL,
   umur INT NOT NULL
);

CREATE TABLE transaksi (
   ID_transaksi CHAR(10) PRIMARY KEY NOT NULL,
   tanggal_transaksi DATE NOT NULL,
   metode_pembayaran VARCHAR(15) NOT NULL,
   customer_ID_customer CHAR(6) NOT NULL,
   pegawai_NIK CHAR(16) NOT NULL,
   FOREIGN KEY (customer_ID_customer) REFERENCES customer(ID_customer),
   FOREIGN KEY (pegawai_NIK) REFERENCES pegawai(NIK)
);

CREATE TABLE telepon (
   no_telp_pegaawai VARCHAR(15) PRIMARY KEY NOT NULL,
   pegawai_NIK CHAR(16) NOT NULL,
   FOREIGN KEY (pegawai_NIK) REFERENCES pegawai(NIK)
);

CREATE TABLE menu_minuman (
   ID_minuman CHAR(6) PRIMARY KEY NOT NULL,
   nama_minuman VARCHAR(50) NOT NULL,
   harga_minuman FLOAT(2) NOT NULL
);

CREATE TABLE transaksi_minuman (
   TM_menu_minuman_ID CHAR(6) NOT NULL,
   TM_transaksi_ID CHAR(10) NOT NULL,
   jumlah_cup INT NOT NULL,
   FOREIGN KEY (TM_menu_minuman_ID) REFERENCES menu_minuman(ID_minuman),
   FOREIGN KEY (TM_transaksi_ID) REFERENCES transaksi(ID_transaksi)
);

-- 2. Tabel Membership

CREATE TABLE membership (
   id_membership CHAR(6) NOT NULL,
   no_telepon_customer VARCHAR(15) NOT NULL,
   alamat_customer VARCHAR(100) NOT NULL,
   tanggal_pembuatan_kartu_membership DATE NOT NULL,
   tanggal_kadaluwarsa_kartu_membership DATE,
   total_poin INT NOT NULL,
   customer_id_customer CHAR(6) NOT NULL
);

-- Soal a
ALTER TABLE membership ADD PRIMARY KEY (id_membership);

-- Soal b 
ALTER TABLE membership
ADD FOREIGN KEY (customer_id_customer) REFERENCES customer(ID_customer)
ON UPDATE CASCADE
ON DELETE RESTRICT;

-- Soal c 
ALTER TABLE transaksi
ADD FOREIGN KEY (customer_ID_customer) REFERENCES customer(ID_customer)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Soal d
ALTER TABLE membership
ALTER COLUMN tanggal_pembuatan_kartu_membership SET DEFAULT CURDATE();

-- Soal e
ALTER TABLE membership
ADD CHECK (total_poin >= 0);

-- Soal f
ALTER TABLE membership
MODIFY alamat_customer VARCHAR(150); 

-- 3. Menghilangkan tabel telepon dan menambah atribut nomor telepon
DROP TABLE telepon;

ALTER TABLE pegawai
ADD COLUMN nomor_telepon VARCHAR(15) NOT NULL;


-- 4. Memasukan data pada tabel

INSERT INTO customer (ID_customer, nama_customer)
VALUES 
	('CTR001', 'Budi Santoso'), 
	('CTR002', 'Sisil Triana'),
	('CTR003', 'Davi Liam'), 
	('CTRo04', 'Sutris Ten An'), 
	('CTR005', 'Hendra Asto');
		 
INSERT INTO membership (id_membership, no_telepon_customer, alamat_customer, 
                        tanggal_pembuatan_kartu_membership, tanggal_kadaluwarsa_kartu_membership, 
                        total_poin, customer_id_customer)
VALUES 
	('MBR001', '08123456789', 'Jl. Imam Bonjol', '2023-10-24', '2023-11-30', 0, 'CTR001'),
	('MBR002', '0812345678', 'Jl. Kelinci', '2023-10-24', '2023-11-30', 3, 'CTR002'),
	('MBR003', '081234567890', 'Jl. Abah Ojak', '2022-10-25', '2023-12-01', 2, 'CTR003'),
	('MBR004', '08987654321', 'Jl. Kenangan', '2023-10-26', '2023-12-02', 6, 'CTR005');
	    

INSERT INTO pegawai (NIK, nama_pegawai, jenis_kelamin, email, umur, nomor_telepon)
VALUES 
	('1234567890123456', 'Naufal Raf', 'L', 'nuafal@gmail.com', '19', '62123456789'),
	('2345678901234561', 'Surinala', 'P', 'surinala@gmail.com', '24', '621234567890'),
	('3456789012345612', 'Ben John', 'L', 'benjohn@gmail.com', '22', '62123445678');
		 
		 
INSERT INTO transaksi (ID_transaksi, tanggal_transaksi, metode_pembayaran, customer_ID_customer, pegawai_NIK)
VALUES 
	('TRX0000001', '2023-10-01', 'Kartu kredit', 'CTR002', '2345678901234561'), 
 	('TRX0000002', '2023-10-03', 'Transfer bank', 'CTRo04', '3456789012345612'),
   ('TRX0000003', '2023-10-05', 'Tunai', 'CTR001', '3456789012345612'),
  	('TRX0000004', '2023-10-15', 'Kartu debit', 'CTR003', '1234567890123456'),
   ('TRX0000005', '2023-10-15', 'E-wallet', 'CTRo04', '1234567890123456'),
   ('TRX0000006', '2023-10-21', 'Tunai', 'CTR001', '2345678901234561');
   	 
INSERT INTO menu_minuman (ID_minuman, nama_minuman, harga_minuman)
VALUES 
	('MNM001', 'Expresso', 18000),
   ('MNM002', 'Cappuccino', 20000),
	('MNM003', 'Latte', 21000),
 	('MNM004', 'Americano', 19000),
 	('MNM005', 'Mocha', 22000),
 	('MNM006', 'Macchiato', 23000),
 	('MNM007', 'Cold Brew', 21000),
  	('MNM008', 'Iced Coffee', 18000),
 	('MNM009', 'Affogato', 23000),
  	('MNM010', 'Coffee Frappe', 22000);
    

INSERT INTO transaksi_minuman (TM_transaksi_ID, TM_menu_minuman_ID, jumlah_cup)
VALUES 
	('TRX0000005', 'MNM006', '2'),
	('TRX0000001', 'MNM010', '1'),
	('TRX0000002', 'MNM005', '1'),
	('TRX0000005', 'MNM009', '1'),
	('TRX0000003', 'MNM001', '3'),
	('TRX0000006', 'MNM003', '2'),
	('TRX0000004', 'MNM004', '2'),
	('TRX0000004', 'MNM010', '1'),
	('TRX0000002', 'MNM003', '2'),
	('TRX0000001', 'MNM007', '1'),
	('TRX0000005', 'MNM001', '1'),
	('TRX0000003', 'MNM003', '1');
   
-- 5. Penambahan data pada databse untuk transasi
SELECT @pegawai_NIK := NIK FROM pegawai WHERE nama_pegawai = 'surinala';

SELECT @menu_minuman_ID := ID_minuman FROM menu_minuman WHERE nama_minuman = 'Mocha';

INSERT INTO transaksi (ID_transaksi, tanggal_transaksi, metode_pembayaran, customer_ID_customer, pegawai_NIK)
VALUES ('TRX0000007', '2023-10-03', 'Transfer bank', 'CTRo04', @pegawai_NIK);
transaksi
INSERT INTO transaksi_minuman (TM_transaksi_ID, TM_menu_minuman_ID, jumlah_cup)
VALUES ('TRX0000007', @menu_minuman_ID, 1);

-- 6. Penambahan data pegawai
INSERT INTO pegawai (NIK, nama_pegawai, umur)
VALUES ('1111222233334444', 'Maimunah', '25');

-- 7. Mengupdate CTRo04 menjadi CTR004
SET FOREIGN_KEY_CHECKS=0;

UPDATE customer
SET ID_customer = 'CTR004'
WHERE ID_customer = 'CTRo04';

UPDATE transaksi
SET customer_ID_customer = 'CTR004'
WHERE customer_ID_customer = 'CTRo04';

SET FOREIGN_KEY_CHECKS=1;

-- 8. Mengupdate data maimunah
UPDATE pegawai
SET jenis_kelamin = 'P', email = 'maimunah@gmail.com', nomor_telepon = '621234567'
WHERE NIK = '1111222233334444';

-- 9. Mereset poin tiap awal bulan
UPDATE membership
SET total_poin = 0
WHERE MONTH(tanggal_kadaluwarsa_kartu_membership) < 12 AND YEAR(tanggal_kadaluwarsa_kartu_membership) = 2023;

-- 10. Menghapus semua data membership
DELETE FROM membership;

-- 11. Menghapus data maimunah
DELETE FROM pegawai WHERE nama_pegawai = 'Maimunah';
