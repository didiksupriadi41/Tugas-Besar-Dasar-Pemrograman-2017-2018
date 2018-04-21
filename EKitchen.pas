Program EKitchen;
uses sysutils, uSimulasi, math;

procedure title();
begin
	writeln();
	writeln('	][==============================================================================================[]');
	writeln('	][                                                                                              []');
	writeln('	][  EEEEE  NN   NN   GGGGG   II ''''          KK  KK  II  TTTTTT   CCCC   HH  HH  EEEEE  NN   NN  []');
	writeln('	][  EE     NNN  NN  GG       II ''''  ssss    KK KK   II    TT    CC  CC  HH  HH  EE     NNN  NN  []');
	writeln('	][  EEEEE  NN N NN  GG  GGG  II    ss_      KKKK    II    TT    C       HHHHHH  EEEEE  NN N NN  []');
	writeln('	][  EE     NN  NNN  GG   GG  II       ss    KK KK   II    TT    CC  CC  HH  HH  EE     NN  NNN  []');
	writeln('	][  EEEEE  NN   NN   GGGGG   II    ssss     KK  KK  II    TT     CCCC   HH  HH  EEEEE  NN   NN  []');
	writeln('	][                                                                                              []');
	writeln('	][==============================================================================================[]');
	writeln();
end;
procedure prompt();
var
	command : string;
	space : integer;
begin
	repeat
		writeln('Ketik ''menu'' untuk melihat pilihan menu');
		write('> ');
		readln(command);
		if (pos(' ', command) > 0) then begin
			space := pos(' ', command) - 1;
			val(copy(command, space + 1, 2), simulasiPilihan);
			command := copy(command, 1, space);
		end;
		case (command) of
			'load' : begin
				F1load();
				writeln();
			end;
			'exit' : begin
				F2exit();
			end;
			'start' : begin
				F3startSimulasi();
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
				writeln('load                Melakukan loading data');
				writeln('exit                Keluar dari program');
				writeln('start [Nomor]       Memulai simulasi ke-[Nomor]');
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
	until (command = 'exit');
end;
begin
	title();
	prompt();
	//credit();
end.