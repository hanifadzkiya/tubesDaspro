unit load;

{
	Cek testing :
	1. Bahan Mentah : Success;
	2. Bahan Olahan : Success;
	3. Inventori Bahan Mentah : Success;
	4. Inventori Bahan Olahan : Success;
	5. Resep : Success;
	6. Simulasi : Success;
}
 
interface

type
	tanggal = record
		hari: integer;
		bulan: integer;
		tahun: integer;
	end;
 
	bahanMentah = record
		namaBahanMentah: string;
		hargaSatuan: integer;
		durasiKadaluarsa: integer;
	end;
 
	bahanOlahan = record
		namaBahanOlahan: string;
		hargaJual: integer;
		n: integer;
		bahan: array[1..10] of string;
	end;
 
	inventoriBahanMentah = record
		namaBahanMentah: string;
		tanggalBeli: tanggal;
		jumlah: integer;
	end;
 
	inventoriBahanOlahan = record
		namaBahanOlahan: string;
		tanggalBuat: tanggal;
		jumlah: integer;
	end;
 
	resep = record
		namaResep: string;
		hargaJual: integer;
		n: integer;
		bahan: array[1..20] of string;
	end;
 
	simulasi = record
		nomorSimulasi: integer;
		tanggal: tanggal;
		jumlahHariHidup: integer;
		jumlahEnergi: integer;
		kapasitasMaksimumInventori: integer;
		totalBahanMentahDibeli: integer;
		totalBahanOlahanDibuat: integer;
		totalBahanOlahanDijual: integer;
		totalResepDijual: integer;
		totalPemasukan: integer;
		totalPengeluaran: integer;
		totalPendapatan: integer;
	end;
 
	dataUtama = record
		bahanMentah: array[1..99] of bahanMentah;
		bahanOlahan: array[1..99] of bahanOlahan;
		inventoriBahanMentah: array[1..99] of inventoriBahanMentah;
		inventoriBahanOlahan: array[1..99] of inventoriBahanOlahan;
		resep: array[1..99] of resep;
		simulasi: array[1..99] of simulasi;
	end;
 
var
	dataPusat: dataUtama;
	j,i: integer;

function stringToInt(value: string): integer;
procedure date(value: string;var option: tanggal);
function getData(var value: string): string;
procedure loading();
implementation

function stringToInt(value: string): integer;
var error: integer;
begin
	val(value, stringToInt, error);
end;
 
procedure date(value: string;var option: tanggal);
begin
	option.hari := stringToInt(copy(value,1,pos('/', value) - 1));
	value := copy(value, (pos('/', value) + 1),length(value));
	option.bulan := stringToInt(copy(value,1,pos('/', value) - 1));
	value := copy(value, (pos('/', value) + 1),length(value));
	option.tahun := stringToInt(value)
end;
 
function getData(var value: string): string;
begin
	if (pos(' | ', value) = 0) then
		getData := value
	else
		getData := copy(value, 1, (pos(' | ', value) - 1));
 
	value := copy(value, (pos(' | ', value) + 3), length(value));
end;
 
procedure loading();
var
	data, temp: string;
	seq, i: integer;
	r: text;
 
begin
	assign(r, 'bahanMentah.txt'); reset(r); seq := 0;
	while (not EOF(r)) do
	begin
		readln(r, data); seq := seq + 1;
		dataPusat.bahanMentah[seq].namaBahanMentah := getData(data);
		dataPusat.bahanMentah[seq].hargaSatuan := stringToInt(getData(data));
		dataPusat.bahanMentah[seq].durasiKadaluarsa := stringToInt(getData(data));
	end;
 
	assign(r, 'bahanOlahan.txt'); reset(r); seq := 0;
	while (not EOF(r)) do
	begin
		readln(r, data); seq := seq + 1;
		dataPusat.bahanOlahan[seq].namaBahanOlahan := getData(data);
		dataPusat.bahanOlahan[seq].hargaJual := stringToInt(getData(data));
		dataPusat.bahanOlahan[seq].n := stringToInt(getData(data));
		for i := 1 to dataPusat.bahanOlahan[seq].n do dataPusat.bahanOlahan[seq].bahan[i] := getData(data);
	end;
 
	assign(r, 'inventoriBahanMentah.txt'); reset(r); seq := 0;
	while (not EOF(r)) do
	begin
		readln(r, data); seq := seq + 1;
		dataPusat.inventoriBahanMentah[seq].namaBahanMentah := getData(data);
		temp := getData(data);
		date(temp, dataPusat.inventoriBahanMentah[seq].tanggalBeli);
		dataPusat.inventoriBahanMentah[seq].jumlah := stringToInt(getData(data));
	end;
 
	assign(r, 'inventoriBahanOlahan.txt'); reset(r); seq := 0;
	while (not EOF(r)) do
	begin
		readln(r, data); seq := seq + 1;
		dataPusat.inventoriBahanOlahan[seq].namaBahanOlahan := getData(data);
		temp := getData(data);
		date(temp, dataPusat.inventoriBahanOlahan[seq].tanggalBuat);
		dataPusat.inventoriBahanOlahan[seq].jumlah := stringToInt(getData(data));
	end;
 
	assign(r, 'resep.txt'); reset(r); seq := 0;
	while (not EOF(r)) do
	begin
		readln(r, data); seq := seq + 1;
		dataPusat.resep[seq].namaResep := getData(data);
		dataPusat.resep[seq].hargaJual := stringToInt(getData(data));
		dataPusat.resep[seq].n := stringToInt(getData(data));
		for i := 1 to dataPusat.resep[seq].n do dataPusat.resep[seq].bahan[i] := getData(data);
	end;
 
	assign(r, 'simulasi.txt'); reset(r); seq := 0;
	while (not EOF(r)) do
	begin
		readln(r, data); seq := seq + 1;
		dataPusat.simulasi[seq].nomorSimulasi := stringToInt(getData(data));
		temp := getData(data);
		date(temp, dataPusat.simulasi[seq].tanggal);
		dataPusat.simulasi[seq].jumlahHariHidup := stringToInt(getData(data));
		dataPusat.simulasi[seq].jumlahEnergi := stringToInt(getData(data));
		dataPusat.simulasi[seq].kapasitasMaksimumInventori := stringToInt(getData(data));
		dataPusat.simulasi[seq].totalBahanMentahDibeli := stringToInt(getData(data));
		dataPusat.simulasi[seq].totalBahanOlahanDibuat := stringToInt(getData(data));
		dataPusat.simulasi[seq].totalBahanOlahanDijual := stringToInt(getData(data));
		dataPusat.simulasi[seq].totalResepDijual := stringToInt(getData(data));
		dataPusat.simulasi[seq].totalPemasukan := stringToInt(getData(data));
		dataPusat.simulasi[seq].totalPengeluaran := stringToInt(getData(data));
		dataPusat.simulasi[seq].totalPendapatan := stringToInt(getData(data));
	end;
end;

begin

end.