library ieee;
use ieee.std_logic_1164.all;

entity sincronizador is
	port(
			reset_n : in std_logic;
			config : in std_logic;
			clk : in std_logic;
			ini_pausa : in std_logic;
			jugador_act : in std_logic;
			bunus : in std_logic;
			modo : in std_logic_vector(1 downto 0);
			en_modo : in std_logic;
			ver_disp : in std_logic_vector(1 downto 0);
			en_vd : in std_logic;
			config_sync : out std_logic;
			ini_pausa_sync : out std_logic;
			jugador_act_Sync : out std_logic;
			ver_disp_sync : out std_logic_vector(1 downto 0);
			bunus_sync : out std_logic;
			modo_sync : out std_logic_vector(1 downto 0));

end sincronizador;
 
architecture conc of sincronizador is

component ff_d is
	port(
	        clk, reset_n, d: in std_logic;
		     q: out std_logic);
end component;

component reg_d is
	port(
	        reset_n, clk: in std_logic;
		     d: in std_logic_vector(3 downto 0);
		     q: out std_logic_vector(3 downto 0));
end component;

component deco2a4 is
	port(   
	        en : in std_logic;
			  w: in std_logic_vector(1 downto 0);
			  y : out std_logic_vector(3 downto 0));

end component;

component cod4a2 is
	port(
	        w: in std_logic_vector(3 downto 0);
		     z: out std_logic;
		     y: out std_logic_vector(1 downto 0));
			  
end component;

signal config_in,ini_pausa_in ,jugador_act_in,bunus_in,z1,z2: std_logic;
signal y1,y1_a,y1_b,y2,y2_a,y2_b : std_logic_vector(3 downto 0);

begin
 
ffd1: ff_d port map(d=>config, q=>config_in, clk=>clk, reset_n=>reset_n);
ffd2: ff_d port map(d=>config_in, q=>config_sync, clk=>clk, reset_n=>reset_n);
ffd3: ff_d port map(d=>ini_pausa, q=>ini_pausa_in, clk=>clk, reset_n=>reset_n);
ffd4: ff_d port map(d=>ini_pausa_in, q=>ini_pausa_sync, clk=>clk, reset_n=>reset_n);
ffd5: ff_d port map(d=>jugador_act, q=>jugador_act_in, clk=>clk, reset_n=>reset_n);
ffd6: ff_d port map(d=>jugador_act_in, q=>jugador_act_sync, clk=>clk, reset_n=>reset_n);
ffd7: ff_d port map(d=>bunus, q=>bunus_in, clk=>clk, reset_n=>reset_n);
ffd8: ff_d port map(d=>bunus_in, q=>bunus_sync, clk=>clk, reset_n=>reset_n);

deco1: deco2a4 port map (w=>modo, en=>en_modo, y=>y1);
regd1: reg_d port map (d=>y1, q=>y1_a, clk=>clk, reset_n=>reset_n);
regd2: reg_d port map (d=>y1_a, q=>y1_b, clk=>clk, reset_n=>reset_n);
cod1: cod4a2 port map (w=>y1_b, y=>modo_sync, z =>z1);

deco2: deco2a4 port map (w=>ver_disp, en=>en_vd, y=>y2);
regd3: reg_d port map (d=>y2, q=>y2_a, clk=>clk, reset_n=>reset_n);
regd4: reg_d port map (d=>y2_a, q=>y2_b, clk=>clk, reset_n=>reset_n);
cod2: cod4a2 port map (w=>y2_b, y=>ver_disp_sync, z =>z2);

end conc;