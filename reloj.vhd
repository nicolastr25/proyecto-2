library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.my_components.all;

entity reloj is
	port( 
		reset_n: in std_logic;
		clk: in std_logic;
		ini_pausa: in std_logic;
		borrar: in std_logic;
		sel: in std_logic_vector(1 downto 0);
		display0: out std_logic_vector(6 downto 0);
		display1: out std_logic_vector(6 downto 0);
		display2: out std_logic_vector(6 downto 0);
		display3: out std_logic_vector(6 downto 0);
		display4: out std_logic_vector(6 downto 0);
		display5: out std_logic_vector(6 downto 0);
		min_value: out std_logic
	);
end reloj;

architecture final of reloj is
signal clk_en, en_seg, en_min, en_hor, g_reset_n, min_seg, min_min, min_hor : std_logic;
signal seg,min_o, hor_o: std_logic_vector(5 downto 0);
signal min: std_logic_vector(5 downto 0);
signal hor: std_logic_vector(1 downto 0);
signal bintosec, bintomin, bintohor: std_logic_vector(7 downto 0);
begin
	--Primero ponemos el divisor de frecuencia
	divisor_frecuencia : divisor_freq port map(reset_n=>reset_n, clk=> clk, clk_o=> clk_en);
	--Luego creamos el enable para los segundos
	en_seg <= clk_en and ini_pausa;
	--Además creamos el reset_g para los contadores de Modulo 60 y 60
	g_reset_n <= (not(borrar) or ini_pausa) and reset_n;
	--Contador de modulo 60
	contador_descendente_modulo_60: counter_mod_seg generic map(n=>60) port map (reset_n=> g_reset_n, en=>en_seg , clk=> clk, q => seg);
	--hallamos min_seg
	comparar: comparador generic map(n=>6) port map(a => seg, b => "000000" , eq => min_seg);
	--Lo convertimos con bintobcd
	binto: bintobcd port map(a => seg, f => bintosec);
	--Lo mostramos en el hexa
	hexa1: hexa port map(a => bintosec(7 downto 4), f => display1);
	hexa2: hexa port map(a => bintosec(3 downto 0), f => display0);
	--Creamos el enable para los minutos
	en_min <= en_seg and min_seg;
	--Contador de modulo 60 minutos
	contador_descendente_modulo_60min: counter_mod_min generic map(n=>60) port map (reset_n=> g_reset_n, en=>en_min , clk=> clk, sel => sel, q => min);
	--hallamos max_min
	comparar2: comparador generic map (n=> 6) port map(a => min, b => "000000" , eq => min_min);
	--Lo convertimos con bintobcd
	min_o <= min;
	binto2: bintobcd port map(a => min_o, f => bintomin);
	--Lo mostramos en el hexa
	hexa3: hexa port map(a => bintomin(7 downto 4), f => display3);
	hexa4: hexa port map(a => bintomin(3 downto 0), f => display2);
	--Creamos el enable para las horas
	en_hor <= en_min and min_min;
	--Contador de modulo 2 horas
	contador_descendente_modulo_2: counter_mod_hor generic map(n=>2) port map (reset_n=> g_reset_n, en=>en_hor , clk=> clk,sel => sel, q => hor);
	--hallamos min_hor
	comparar3: comparador generic map (n=> 2) port map(a => hor, b => "00" , eq => min_hor);
	--Lo convertimos con bintobcd
	hor_o <= "0000" & hor;
	binto3: bintobcd port map(a => hor_o, f => bintohor);
	--Lo mostramos en el hexa
	hexa5: hexa port map(a => bintohor(7 downto 4), f => display5);
	hexa6: hexa port map(a => bintohor(3 downto 0), f => display4);
	--Minvalue
	min_value <= min_min and min_seg and min_hor;
	
end final;
