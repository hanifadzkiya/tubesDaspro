uses load;

var ask : string;
	hasil : integer;

function findResep(ask : string;var hasil : integer;resep : array of resep):boolean;
var left,right,mid,i : integer;
begin
	left := 0;
	right := 4;
	hasil := -1;
	while((left <= right) and (hasil = -1)) do
	begin
		mid := (left + right) div 2;
		if(resep[mid].namaResep < ask) then
		begin
			left := mid + 1;
		end else if(resep[mid].namaResep > ask) then
		begin
			right := mid - 1;
		end else hasil := mid;
	end;
	findResep := (hasil > -1);
end;

procedure askUser();
begin
	writeln('Hem... Masukkan resep yang ingin dicari :');
	readln(ask);
end;

procedure cetakResep(hasil : integer;resep : array of resep);
var i : integer;
begin
	write(resep[hasil].namaResep);
	write(' | ',resep[hasil].hargaJual);
	write(' | ',resep[hasil].n);
	i := 1;
	while(length(resep[hasil].bahan[i]) > 0) do
	begin
		write(' | ',resep[hasil].bahan[i]);
		i := i + 1;
	end;
	writeln;
end;

begin
	loading();
	askUser();
	if(findResep(ask,hasil,dataPusat.resep)) then
	begin
		cetakResep(hasil,dataPusat.resep);
	end else
	begin
		writeln('Resep yang dicari tidak ada :(');
	end;
end.