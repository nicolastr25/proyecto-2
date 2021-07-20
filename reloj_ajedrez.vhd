library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.my_comps.all;

entity reloj_ajedrez is 
	port(
		reset_n: in std_logic;
		clk: in std_logic;
		config: in std_logic;
		jugador_act: in std_logic;
		bonus: in std_logic;
		ini_pausa: in std_logic;
		modo: in std_logic_vector(1 downto 0);
		ver_disp: in std_logic_vector(1 downto 0);
		display0: out std_logic_vector(6 downto 0);
		display1: out std_logic_vector(6 downto 0);
		display2: out std_logic_vector(6 downto 0);
		display3: out std_logic_vector(6 downto 0);
		display4: out std_logic_vector(6 downto 0);
		display5: out std_logic_vector(6 downto 0)
		
	);
end reloj_ajedrez;

architecture finalreloj of reloj_ajedrez is

signal en : std_logic;
signal en_sel : std_logic;
signal en_j0, en_j1: std_logic;
signal en_en_j0, en_en_j1: std_logic; 
signal mov_j0_eq40, mov_j1_eq40, mov_j0_mayor40, mov_j1_mayor40, mov_j0_gt40, mov_j1_gt40 : std_logic;
signal mov_u_j0, mov_d_j0, mov_c_j0: std_logic_vector(6 downto 0);
signal mov_u_j1, mov_d_j1, mov_c_j1: std_logic_vector(6 downto 0);
signal mov_j0: std_logic_vector(7 downto 0);
signal mov_j1: std_logic_vector(7 downto 0);
signal mov_j0_bcd: std_logic_vector(11 downto 0);
signal mov_j1_bcd: std_logic_vector(11 downto 0);
signal config_sync, ini_pausa_sync, jugador_act_sync, bonus_sync : std_logic;
signal modo_sync, ver_disp_sync : std_logic_vector(1 downto 0);
signal ini_pausa_j0, ini_pausa_j1, borrar_j0, borrar_j1, min_value_j0, min_value_j1 : std_logic;
signal sel : std_logic_vector(1 downto 0);
signal display0_j0,display1_j0,display2_j0,display3_j0,display4_j0,display5_j0,display0_j1,display1_j1,display2_j1,display3_j1,display4_j1,display5_j1 : std_logic_vector (6 downto 0);

begin

	--divisor de frecuencia de 100 / 500K
	divisor: divisor_freq2 port map(reset_n=>reset_n, clk=> clk, clk_o=> en);
	--sincronizador 
	sincronizador1: sincronizador port map(reset_n => reset_n, clk=> clk, config=>config, ini_pausa=>ini_pausa, jugador_act=>jugador_act, bunus=>bonus, modo=>modo, ver_disp=> ver_disp, en_modo => '1' , en_vd => '1', config_sync => config_sync , ini_pausa_sync=>ini_pausa_sync , jugador_act_sync=>jugador_act_sync, bunus_sync =>bonus_sync, modo_sync => modo_sync, ver_disp_sync=> ver_disp_sync );
	--FSM 
	fsm1: fsm port map(reset_n => reset_n, en=> en, config => config_sync, ini_pausa => ini_pausa_sync, jugador_act => jugador_act_sync, modo => modo_sync, min_value_j0 => min_value_j0, min_value_j1 => min_value_j1, clk => clk , ini_pausa_j0 => ini_pausa_j0 , borrar_j0 => borrar_j0, ini_pausa_j1 => ini_pausa_j1 , borrar_j1 => borrar_j1 , en_sel => en_sel, mov_j0_gt40 => mov_j0_gt40, mov_j1_gt40 => mov_j1_gt40, en_j0 => en_j0 , en_j1 => en_j1 );
	--Reg
	registro: reg port map( reset_n => reset_n, en => en_sel , d => modo_sync , clk => clk , q => sel );
	--reloj1
	reloj1: reloj port map(clk=>clk, reset_n=> reset_n, ini_pausa => ini_pausa_j0, borrar => borrar_j0 , sel => sel , min_value=> min_value_j0 , display0 => display0_j0 , display1 => display1_j0 , display2 => display2_j0 , display3 => display3_j0 , display4 => display4_j0 ,  display5 => display5_j0 );
	--reloj2
	reloj2: reloj port map(clk=>clk, reset_n=> reset_n, ini_pausa => ini_pausa_j1, borrar => borrar_j1 , sel => sel , min_value=> min_value_j1 , display0 => display0_j1 , display1 => display1_j1 , display2 => display2_j1 , display3 => display3_j1 , display4 => display4_j1 ,  display5 => display5_j1 );
	--enable y contadores ascedentes jugadores 0 y 1
	en_en_j0 <= en and en_j0;
	en_en_j1 <= en and en_j1;
	jugador0: counter_movimientos_j generic map (n=>255) port map(reset_n=> reset_n, en=>en_en_j0 , clk=> clk, q => mov_j0);
	--
	comparadorj0: comparador2 generic map (n=>8) port map( a => mov_j0, b => "00101000" , eq => mov_j0_eq40);
	comparadorj0_1: comparador3 generic map (n=>8) port map( a => mov_j0, b => "00101000" , eq => mov_j0_mayor40);
	mov_j0_gt40 <= mov_j0_eq40 or mov_j0_mayor40;
	--
	bintobcd_j0: bintobcd2 port map(a => mov_j0, f => mov_j0_bcd);
	hexaj0_c: hexa2 port map(a => mov_j0_bcd(11 downto 8), f => mov_c_j0);
	hexaj0_d: hexa2 port map(a => mov_j0_bcd(7 downto 4), f => mov_d_j0);
	hexaj0_u: hexa2 port map(a => mov_j0_bcd(3 downto 0), f => mov_u_j0);
	--------
	jugador1: counter_movimientos_j generic map (n=>255) port map(reset_n=> reset_n, en=>en_en_j1 , clk=> clk, q => mov_j1);
	----
	comparadorj1: comparador2 generic map (n=>8) port map( a => mov_j0, b => "00101000" , eq => mov_j1_eq40);
	comparadorj1_1: comparador3 generic map (n=>8) port map( a => mov_j0, b => "00101000" , eq => mov_j1_mayor40);
	mov_j1_gt40 <= mov_j1_eq40 or mov_j1_mayor40;
	----
	bintobcd_j1: bintobcd2 port map(a => mov_j1, f => mov_j1_bcd);
	hexaj1_c: hexa2 port map(a => mov_j1_bcd(11 downto 8), f => mov_c_j1);
	hexaj1_d: hexa2 port map(a => mov_j1_bcd(7 downto 4), f => mov_d_j1);
	hexaj1_u: hexa2 port map(a => mov_j1_bcd(3 downto 0), f => mov_u_j1);
	
	--displays
	display_0: mux_4a1 port map(A => display0_j0, B => mov_u_j0 , C => display0_j1 , D => mov_u_j1 , display => display0 , sel => ver_disp_sync);
	display_1: mux_4a1 port map(A => display1_j0, B => mov_d_j0 , C => display1_j1 , D => mov_d_j1 , display => display1 , sel => ver_disp_sync);
	display_2: mux_4a1 port map(A => display2_j0, B => mov_c_j0 , C => display2_j1 , D => mov_c_j1 , display => display2 , sel => ver_disp_sync);
	display_3: mux_4a1 port map(A => display3_j0, B => "1111111" , C => display3_j1 , D => "1111111" , display => display3 , sel => ver_disp_sync);
	display_4: mux_4a1 port map(A => display4_j0, B => "1111111" , C => display4_j1 , D => "1111111" , display => display4 , sel => ver_disp_sync);
	display_5: mux_4a1 port map(A => display5_j0, B => "1111111" , C => display5_j1 , D => "1111111" , display => display5 , sel => ver_disp_sync);
	
end finalreloj;