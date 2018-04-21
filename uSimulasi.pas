unit uSimulasi;
interface
uses math, sysutils;
const
	NMax = 100;

type 
	BahanMentah = record
		Nama 	: string;
		Harga	: Longint;
		Durasi	: Integer; 
		
	end;

	TBahan = array[1..NMax] of string;

	BahanOlahan = record
		Nama 	: string;
		Harga	: longint;
		N 		: Integer;
		TabBahan: TBahan;

	end;

	Date = record
		Hari 	: Integer;
		Bulan	: integer;
		Tahun	: integer;
		
	end;

	Inventori = record
		Nama	: string;
		Tanggal	: Date;
		Jumlah	: Integer;		
	end;

	TabBahanOlahan = array[1..NMax] of string;

	Resep = record
		Nama		: String;
		Harga		: longint;
		N 			: Integer;
		TabBOlahan	: TabBahanOlahan;
	end;

	TBahanMentah = array[1..NMax] of BahanMentah;
	TBahanOlahan = array[1..NMax] of BahanOlahan;
	TInventori = array[1..NMax] of Inventori;
	TResep = array[1..NMax] of Resep;

	Simulasi = record
		Nomor 			: Integer;
		Tanggal			: Date;
		HariHidup		: Integer;
		Energi			: Integer;
		KInventori		: Integer;
		TotalBMentah	: Integer;
		TotalBOBuat		: Integer;
		TotalBOJual		: Integer;
		TotalResepJual	: Integer;
		TotalPemasukan	: Integer;
		TotalPengeluaran: Integer;
		TotalUang		: Integer;
		
	end;
	TSimulasi = array[1..Nmax] of Simulasi;
var
	listBahanMentah : TBahanMentah;
	listBahanOlahan : TBahanOlahan;
	listInventoriMentah : TInventori;
	listInventoriOlahan : TInventori;
	listResep : TResep;
	listSimulasi : TSimulasi;
	simulasiPilihan : integer;
//Ekstensi
function isFoundInventori(namaBahan : string; inventori : TInventori) : boolean;
function harga(namaBahan : string) : longint;
procedure validasiResep(resepBaru : Resep);
//Fitur
procedure F1load();
procedure F2exit();
procedure F3startSimulasi();
procedure F4stopSimulasi();
//procedure F5beliBahan();
//procedure F6olahBahan();
//procedure F7jualOlahan();
//procedure F8jualResep();
//procedure F9makan();
//procedure F10istirahat();
//procedure F11tidur();
//procedure F12lihatStatistik();
//procedure F13lihatInventori();
//procedure F14lihatResep();
procedure F15cariResep();
procedure F16tambahResep();
//procedure F17upgradeInventori();

implementation
procedure F1load();
var
	f : text;
	data : string;
	i, j, k, lenToBeCut, guard, slash : integer;
begin
	
	assign(f, 'BahanMentah.txt');
	reset(f);
	j := 1;
	while (not(eof(f))) do begin
		readln(f, data);
		for i := 1 to 3 do begin
			guard := pos(' | ', data) - 1;
			case i of
				1 :	listBahanMentah[j].Nama := copy(data, 1, guard);
				2 : val(copy(data, 1, guard), listBahanMentah[j].Harga);
				3 : listBahanMentah[j].Durasi := strtoint(data);
			end;
			lenToBeCut := length(copy(data, 1, guard)) + 3;
			delete(data, 1, lenToBeCut);
		end;
		j := j + 1;
	end;
	close(f);
	
	//This code has been tested!
	assign(f, 'BahanOlahan.txt');
	reset(f);
	j := 1;
	while (not(eof(f))) do begin
		readln(f, data);
		for i := 1 to 3 do begin
			guard := pos(' | ', data) - 1;
			case i of
				1 :	begin
						listBahanOlahan[j].Nama := copy(data, 1, guard);
					end;
				2 : begin
						val(copy(data, 1, guard), listBahanOlahan[j].Harga);
					end;
				3 : begin
						val(copy(data, 1, guard), listBahanOlahan[j].N);
						lenToBeCut := length(copy(data, 1, guard)) + 3;
						delete(data, 1, lenToBeCut);
						for k := 1 to listBahanOlahan[j].N do begin
							guard := pos(' | ', data) - 1;
							if (k = listBahanOlahan[j].N) then begin
								listBahanOlahan[j].TabBahan[k] := data;
							end else begin
								listBahanOlahan[j].TabBahan[k] := copy(data, 1, guard);
							end;
							lenToBeCut := length(copy(data, 1, guard)) + 3;
							delete(data, 1, lenToBeCut);
						end;
					end;
			end;
			lenToBeCut := length(copy(data, 1, guard)) + 3;
			delete(data, 1, lenToBeCut);
		end;
		j := j + 1;
	end;
	close(f);
	
	//This code has been tested!
	assign(f, 'InventoriBahanMentah.txt');
	reset(f);
	j := 1;
	while (not(eof(f))) do begin
		readln(f, data);
		for i := 1 to 3 do begin
			guard := pos(' | ', data) - 1;
			case i of
				1 :	begin
						listInventoriMentah[j].Nama := copy(data, 1, guard);
					end;
				2 : begin
						slash := pos('/', data) - 1;
						val(copy(data, 1, slash), listInventoriMentah[j].Tanggal.Hari);
						lenToBeCut := length(copy(data, 1, slash)) + 1;
						delete(data, 1, lenToBeCut);
						
						slash := pos('/', data) - 1;
						val(copy(data, 1, slash), listInventoriMentah[j].Tanggal.Bulan);
						lenToBeCut := length(copy(data, 1, slash)) + 1;
						delete(data, 1, lenToBeCut);
						
						guard := pos(' | ', data) - 1;
						val(copy(data, 1, guard), listInventoriMentah[j].Tanggal.Tahun);
					end;
				3 : begin
						listInventoriMentah[j].jumlah := strtoint(data);
					end;
			end;
			lenToBeCut := length(copy(data, 1, guard)) + 3;
			delete(data, 1, lenToBeCut);
		end;
		j := j + 1;
	end;
	close(f);
	
	//This code has been tested!
	assign(f, 'InventoriBahanOlahan.txt');
	reset(f);
	j := 1;
	while (not(eof(f))) do begin
		readln(f, data);
		for i := 1 to 3 do begin
			guard := pos(' | ', data) - 1;
			case i of
				1 :	begin
						listInventoriOlahan[j].Nama := copy(data, 1, guard);
					end;
				2 : begin
						slash := pos('/', data) - 1;
						val(copy(data, 1, slash), listInventoriOlahan[j].Tanggal.Hari);
						lenToBeCut := length(copy(data, 1, slash)) + 1;
						delete(data, 1, lenToBeCut);
						
						slash := pos('/', data) - 1;
						val(copy(data, 1, slash), listInventoriOlahan[j].Tanggal.Bulan);
						lenToBeCut := length(copy(data, 1, slash)) + 1;
						delete(data, 1, lenToBeCut);
						
						guard := pos(' | ', data) - 1;
						val(copy(data, 1, guard), listInventoriOlahan[j].Tanggal.Tahun);
					end;
				3 : begin
						listInventoriOlahan[j].jumlah := strtoint(data);
					end;
			end;
			lenToBeCut := length(copy(data, 1, guard)) + 3;
			delete(data, 1, lenToBeCut);
		end;
		j := j + 1;
	end;
	close(f);
	
	//This code has been tested!
	assign(f, 'Resep.txt');
	reset(f);
	j := 1;
	while (not(eof(f))) do begin
		readln(f, data);
		for i := 1 to 3 do begin
			guard := pos(' | ', data) - 1;
			case i of
				1 :	listResep[j].Nama := copy(data, 1, guard);
				2 : val(copy(data, 1, guard), listResep[j].Harga);
				3 : begin
						val(copy(data, 1, guard), listResep[j].N);
						lenToBeCut := length(copy(data, 1, guard)) + 3;
						delete(data, 1, lenToBeCut);
						for k := 1 to listResep[j].N do begin
							guard := pos(' | ', data) - 1;
							if (k = listResep[j].N) then begin
								listResep[j].TabBOlahan[k] := data;
							end else begin
								listResep[j].TabBOlahan[k] := copy(data, 1, guard);
							end;
							lenToBeCut := length(copy(data, 1, guard)) + 3;
							delete(data, 1, lenToBeCut);
						end;
					end;
			end;
			lenToBeCut := length(copy(data, 1, guard)) + 3;
			delete(data, 1, lenToBeCut);
		end;
		j := j + 1;
	end;
	close(f);
	
	//This code has been tested!
	assign(f, 'Simulasi.txt');
	reset(f);
	j := 1;
	while (not(eof(f))) do begin
		readln(f, data);
		for i := 1 to 12 do begin
			guard := pos(' | ', data) - 1;
			case i of
				1 :	val(copy(data, 1, guard), listSimulasi[j].Nomor);
				2 : begin
						slash := pos('/', data) - 1;
						val(copy(data, 1, slash), listSimulasi[j].Tanggal.Hari);
						lenToBeCut := length(copy(data, 1, slash)) + 1;
						delete(data, 1, lenToBeCut);
						
						slash := pos('/', data) - 1;
						val(copy(data, 1, slash), listSimulasi[j].Tanggal.Bulan);
						lenToBeCut := length(copy(data, 1, slash)) + 1;
						delete(data, 1, lenToBeCut);
						
						guard := pos(' | ', data) - 1;
						val(copy(data, 1, guard), listSimulasi[j].Tanggal.Tahun);
					end;
				3 : val(copy(data, 1, guard), listSimulasi[j].HariHidup);
				4 : val(copy(data, 1, guard), listSimulasi[j].Energi);
				5 : val(copy(data, 1, guard), listSimulasi[j].KInventori);
				6 : val(copy(data, 1, guard), listSimulasi[j].TotalBMentah);
				7 : val(copy(data, 1, guard), listSimulasi[j].TotalBOBuat);
				8 : val(copy(data, 1, guard), listSimulasi[j].TotalBOJual);
				9 : val(copy(data, 1, guard), listSimulasi[j].TotalResepJual);
				10 : val(copy(data, 1, guard), listSimulasi[j].TotalPemasukan);
				11 : val(copy(data, 1, guard), listSimulasi[j].TotalPengeluaran);
				12 : listSimulasi[j].TotalUang := strtoint(data);
			end;
			lenToBeCut := length(copy(data, 1, guard)) + 3;
			delete(data, 1, lenToBeCut);
		end;
		j := j + 1;
	end;
	close(f);
	
	writeln('Loading file sukses.');
end;

procedure F2exit();
var
	f : text;
	i, j : integer;
begin
	// This code has been tested.
	assign(f, 'BahanMentah.txt');
	rewrite(f);
	i := 1;
	while not((listBahanMentah[i].Nama = '') and (listBahanMentah[i].Harga = 0) and (listBahanMentah[i].Durasi = 0)) do begin
		write(f, listBahanMentah[i].Nama);
		write(f, ' | ');
		write(f, listBahanMentah[i].Harga);
		write(f, ' | ');
		write(f, listBahanMentah[i].Durasi);
		i := i + 1;
		writeln(f);
	end;
	close(f);
	
	// This code has been tested.
	assign(f, 'BahanOlahan.txt');
	rewrite(f);
	i := 1;
	while not((listBahanOlahan[i].Nama = '') and (listBahanOlahan[i].Harga = 0) and (listBahanOlahan[i].N = 0)) do begin
		write(f, listBahanOlahan[i].Nama);
		write(f, ' | ');
		write(f, listBahanOlahan[i].Harga);
		write(f, ' | ');
		write(f, listBahanOlahan[i].N);
		for j := 1 to listBahanOlahan[i].N do begin
			write(f, ' | ');
			write(f, listBahanOlahan[i].TabBahan[j]);
		end;
		i := i + 1;
		writeln(f);
	end;
	close(f);
	
	// Has been tested !
	assign(f, 'InventoriBahanMentah.txt');
	rewrite(f);
	i := 1;
	while not((listInventoriMentah[i].Nama = '') and (listInventoriMentah[i].Tanggal.Hari = 0) and (listInventoriMentah[i].Jumlah = 0)) do begin
		write(f, listInventoriMentah[i].Nama);
		write(f, ' | ');
		write(f, listInventoriMentah[i].Tanggal.Hari);
		write(f, '/');
		write(f, listInventoriMentah[i].Tanggal.Bulan);
		write(f, '/');
		write(f, listInventoriMentah[i].Tanggal.Tahun);
		write(f, ' | ');
		write(f, listInventoriMentah[i].Jumlah);
		i := i + 1;
		writeln(f);
	end;
	close(f);
	
	// Has been tested !
	assign(f, 'InventoriBahanOlahan.txt');
	rewrite(f);
	i := 1;
	while not((listInventoriOlahan[i].Nama = '') and (listInventoriOlahan[i].Tanggal.Hari = 0) and (listInventoriOlahan[i].Jumlah = 0)) do begin
		write(f, listInventoriOlahan[i].Nama);
		write(f, ' | ');
		write(f, listInventoriOlahan[i].Tanggal.Hari);
		write(f, '/');
		write(f, listInventoriOlahan[i].Tanggal.Bulan);
		write(f, '/');
		write(f, listInventoriOlahan[i].Tanggal.Tahun);
		write(f, ' | ');
		write(f, listInventoriOlahan[i].Jumlah);
		i := i + 1;
		writeln(f);
	end;
	close(f);
	
	// Has been tested !
	assign(f, 'Resep.txt');
	rewrite(f);
	i := 1;
	while not((listResep[i].Nama = '') and (listResep[i].Harga = 0) and (listResep[i].N = 0)) do begin
		write(f, listResep[i].Nama);
		write(f, ' | ');
		write(f, listResep[i].Harga);
		write(f, ' | ');
		write(f, listResep[i].N);
		for j := 1 to listResep[i].N do begin
			write(f, ' | ');
			write(f, listResep[i].TabBOlahan[j]);
		end;
		i := i + 1;
		writeln(f);
	end;
	close(f);
	
	// Has been tested !
	assign(f, 'Simulasi.txt');
	rewrite(f);
	i := 1;
	while not((listSimulasi[i].Nomor = 0) and (listSimulasi[i].Tanggal.Hari = 0) and (listSimulasi[i].HariHidup = 0)) do begin
		write(f, listSimulasi[i].Nomor);
		write(f, ' | ');
		write(f, listSimulasi[i].Tanggal.Hari);
		write(f, '/');
		write(f, listSimulasi[i].Tanggal.Bulan);
		write(f, '/');
		write(f, listSimulasi[i].Tanggal.Tahun);
		write(f, ' | ');
		write(f, listSimulasi[i].HariHidup);
		write(f, ' | ');
		write(f, listSimulasi[i].Energi);
		write(f, ' | ');
		write(f, listSimulasi[i].KInventori);
		write(f, ' | ');
		write(f, listSimulasi[i].TotalBMentah);
		write(f, ' | ');
		write(f, listSimulasi[i].TotalBOBuat);
		write(f, ' | ');
		write(f, listSimulasi[i].TotalBOJual);
		write(f, ' | ');
		write(f, listSimulasi[i].TotalResepJual);
		write(f, ' | ');
		write(f, listSimulasi[i].TotalPemasukan);
		write(f, ' | ');
		write(f, listSimulasi[i].TotalPengeluaran);
		write(f, ' | ');
		write(f, listSimulasi[i].TotalUang);
		i := i + 1;
		writeln(f);
	end;
	close(f);
end;

procedure F3startSimulasi();
var
	perintah : string;
begin
	writeln('Simulasi ', simulasiPilihan, ' dimulai');
	repeat
		writeln('Ketik ''menu'' untuk melihat perintah simulasi');
		write('>> ');
		readln(perintah);
		case (perintah) of
			'stopSimulasi' : begin
				F4stopSimulasi();
				writeln();
			end;
			'beliBahan' : begin
				//F5beliBahan();
				writeln();
			end;
			'olahBahan' : begin
				//F6olahBahan();
				writeln();
			end;
			'jualOlahan' : begin
				//F7jualOlahan();
				writeln();
			end;
			'jualResep' : begin
				//F8jualResep();
				writeln();
			end;
			'makan' : begin
				//F9makan();
				writeln();
			end;
			'istirahat' : begin
				//F10istirahat();
				writeln();
			end;
			'tidur' : begin
				//F11tidur();
				writeln();
			end;
			'lihatStatistik' : begin
				//F12lihatStatistik();
				writeln();
			end;
			
			'lihatInventori' : begin
				//F13lihatInventori();
				writeln();
			end;
			'lihatResep' : begin
				//F14lihatResep();
				writeln();
			end;
			'cariResep' : begin
				F15cariResep();
				writeln();	
			end;
			'tambahResep' : begin
				F16tambahResep();
				writeln();
			end;
			'upgradeInventori' : begin
				//F17upgradeInventori();
				writeln();
			end;
			'menu' : begin
				writeln('stopSimulasi        Menghentikan simulasi');
				writeln('beliBahan           Membeli bahan mentah');
				writeln('olahBahan           Mengolah bahan mentah');
				writeln('jualOlahan          Menjual bahan olahan');
				writeln('jualResep           Menjual hidangan resep');
				writeln('makan               Melakukan aksi makan');
				writeln('istirahat           Melakukan aksi istirahat');
				writeln('tidur               Melakukan aksi tidur');
				writeln('lihatStatistik      Menampilkan statistik simulasi');
				writeln('lihatInventori      Menampilkan daftar bahan yang tersedia di inventori');
				writeln('lihatResep          Menampilkan datar resep yang tersedia');
				writeln('cariResep           Melakukan pencarian resep berdasarkan nama resep');
				writeln('tambahResep         Melakukan penambahan resep');
				writeln('upgradeInventori    Melakukan perluasan kapasitas inventori');
				writeln();
			end;
			else begin
				writeln();
			end;
		end;
	until (perintah = 'stopSimulasi');
end;

procedure F4stopSimulasi();
begin
	writeln('Simulasi ', simulasiPilihan, ' dihentikan');
	writeln('-Nomor Simulasi: ', listSimulasi[simulasiPilihan].Nomor);
	writeln('-Tanggal: ', listSimulasi[simulasiPilihan].Tanggal.Hari, '/', listSimulasi[simulasiPilihan].Tanggal.Bulan, '/', listSimulasi[simulasiPilihan].Tanggal.Tahun);
	writeln('-Jumlah hari hidup: ', listSimulasi[simulasiPilihan].HariHidup);
	writeln('-Jumlah energi: ', listSimulasi[simulasiPilihan].Energi);
	writeln('-Kapasitas maksimum inventori: ', listSimulasi[simulasiPilihan].KInventori);
	writeln('-Total bahan mentah dibeli: ', listSimulasi[simulasiPilihan].TotalBMentah);
	writeln('-Total bahan olahan dibuat: ', listSimulasi[simulasiPilihan].TotalBOBuat);
	writeln('-Total bahan olahan dijual: ', listSimulasi[simulasiPilihan].TotalBOJual);
	writeln('-Total Resep dijual: ', listSimulasi[simulasiPilihan].TotalResepJual);
	writeln('-Total pemasukan: ', listSimulasi[simulasiPilihan].TotalPemasukan);
	writeln('-Total pengeluaran: ', listSimulasi[simulasiPilihan].TotalPengeluaran);
	writeln('-Total uang: ', listSimulasi[simulasiPilihan].TotalUang);
end;

//procedure F5beliBahan();
//procedure F6olahBahan();
//procedure F7jualOlahan();
//procedure F8jualResep();
//procedure F9makan();
//procedure F10istirahat();
//procedure F11tidur();
//procedure F12lihatStatistik();
//procedure F13lihatInventori();
//procedure F14lihatResep();
procedure F15cariResep();
var
	i, j : integer;
	flag : boolean;
	listResepDicari : string;
begin
	write('Nama Resep: ');
	readln(listResepDicari);
	// Has been tested
	i := 1;
	flag := true;
	while not((listResep[i].Nama = '') and (listResep[i].Harga = 0) and (listResep[i].N = 0)) and (flag) do begin
		if (listResepDicari = listResep[i].Nama) then begin
			
			writeln('Resep <', listResep[i].Nama, '> :');
			for j := 1 to listResep[i].N do begin
				writeln('-', listResep[i].TabBOlahan[j]);
			end;
			writeln('Harga: ', listResep[i].Harga);
			flag := false;
		end;
		i := i + 1;
	end;
	if (flag) then begin
		writeln('Resep tidak ditemukan');
	end;
end;

procedure F16tambahResep();
var
	resepBaru : Resep;
	i : integer;
begin
	write('Nama resep: ');
	readln(resepBaru.Nama);
	write('Harga jual: ');
	readln(resepBaru.Harga);
	write('Banyak bahan: ');
	readln(resepBaru.N);
	for i := 1 to resepBaru.N do begin
		write('Bahan-', i, ': ');
		readln(resepBaru.TabBOlahan[i]);
	end;
	validasiResep(resepBaru);
end;

//procedure F17upgradeInventori();

//Ekstensi
function isFoundInventori(namaBahan : string; inventori : TInventori) : boolean;
var
	i : integer;
begin
	i := 1;
	isFoundInventori := false;
	while not((inventori[i].Nama = '') and (inventori[i].Tanggal.Hari = 0) and (inventori[i].Jumlah = 0)) and not(isFoundInventori) do begin
		if (namaBahan = inventori[i].Nama) then begin
			isFoundInventori := true;
		end;
		i := i + 1;
	end;
end;
function harga(namaBahan : string) : longint;
var
	i : integer;
begin
	i := 1;
	while not(listBahanOlahan[i].Nama = '') or not(listBahanMentah[i].Nama = '') do begin
		if (namaBahan = listBahanOlahan[i].Nama) then begin
			harga := listBahanOlahan[i].Harga;
			break;
		end;
		if (namaBahan = listBahanMentah[i].Nama) then begin
			harga := listBahanMentah[i].Harga;
			break;
		end;
		i := i + 1;
	end;
end;
procedure validasiResep(resepBaru : Resep);
var
	i, j : integer;
	flag : boolean;
	hargaResep, hargaBanding : longint;
begin
	if (resepBaru.N > 1) then begin
		i := 1;
		flag := true;
		while (i <= resepBaru.N) and (flag) do begin
			if not(isFoundInventori(resepBaru.TabBOlahan[i], listInventoriMentah) or isFoundInventori(resepBaru.TabBOlahan[i], listInventoriOlahan)) then begin
				flag := false;
			end;
			i := i + 1;
		end;
		if not(flag) then begin
			writeln('Maaf, bahan tidak tersedia di inventori');
		end else begin
			hargaResep := 0;
			for i := 1 to resepBaru.N do begin
				hargaResep := hargaResep + harga(resepBaru.TabBOlahan[i]);
			end;
			hargaBanding := ceil(1.125 * hargaResep);
			if (resepBaru.Harga > hargaBanding) then begin
				i := 1;
				while not(listResep[i].Nama = '') do begin
					i := i + 1;
				end;
				writeln(i);
				listResep[i].Nama := resepBaru.Nama;
				listResep[i].Harga := resepBaru.Harga;
				listResep[i].N := resepBaru.N;
				for j := 1 to resepBaru.N do begin
					listResep[i].TabBOlahan[j] := resepBaru.TabBOlahan[j];
				end;
			end else begin
				writeln('Maaf, harga harus lebih besar 12,5% dari harga bahan');
			end;
		end;	
	end else begin
		writeln('Maaf, bahan harus lebih dari satu');
	end;
end;

end.