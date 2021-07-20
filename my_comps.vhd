library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package my_comps is
	
	component sincronizador is
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

	end component;
	
	component reloj is
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
	end component;
	
	component divisor_freq2 is
	  generic (N         : natural := 500000;        
				  BUS_WIDTH : natural := 19);
	  port (signal reset_n :  in std_logic;
			  signal clk     :  in std_logic;
			  signal clk_o   : out std_logic);
	end component;
	
	component reg is 
	  port (signal reset_n :  in std_logic;
			  signal clk     :  in std_logic;
			  signal d       :  in std_logic_vector(1 downto 0);  
			  signal en      :  in std_logic;
			  signal q       : out std_logic_vector(1 downto 0)); 
	end component;
	
	component fsm is 
		port(
			reset_n, clk, en, config , ini_pausa, jugador_act, min_value_j0, min_value_j1 : in std_logic;
			mov_j0_gt40, mov_j1_gt40: in std_logic;
			modo: in std_logic_vector(1 downto 0);
			ini_pausa_j0, borrar_j0, ini_pausa_j1, en_j0, en_j1, borrar_j1, en_sel: out std_logic
		);
	end component;
	
	component mux_4a1 is
	 port(
	 
		  A,B,C,D : in std_logic_vector(6 downto 0);
		  sel: in std_logic_vector(1 downto 0);
		  display: out std_logic_vector(6 downto 0)
	  );
	end component;
	
	component bintobcd2 is
	 port(signal a  :  in std_logic_vector(7 downto 0);
			signal f  : out std_logic_vector(11 downto 0)
	 );	
	end component;
	
	component counter_movimientos_j is
		generic (n     : natural := 255;        
				  width : natural :=8
				  );
		port (signal reset_n :  in std_logic;
			  signal clk     :  in std_logic;
			  signal en      :  in std_logic;
			  signal q       : out std_logic_vector(width-1 downto 0)
			  );
	end component;
	
	component hexa2 is
	  port(signal a  :  in std_logic_vector(3 downto 0);
			 signal f  : out std_logic_vector(6 downto 0)) ;
	end component;

	component comparador2 is
		generic(
			n: integer := 8
		);
		port(
			a : in std_logic_vector(n-1 downto 0);
			b : in std_logic_vector(n-1 downto 0);
			eq : out std_logic
		);
	end component;

	component comparador3 is
		generic(
			n: integer := 8
		);
		port(
			a : in std_logic_vector(n-1 downto 0);
			b : in std_logic_vector(n-1 downto 0);
			eq : out std_logic
		);
	end component;

end package;