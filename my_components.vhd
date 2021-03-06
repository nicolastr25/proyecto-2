library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package my_components is
	
	component divisor_freq is
	  generic (N         : natural := 50000000;        
				  BUS_WIDTH : natural := 26);
	  port (signal reset_n :  in std_logic;
			  signal clk     :  in std_logic;
			  signal clk_o   : out std_logic);
	end component;
	component bintobcd is
	  port(signal a  :  in std_logic_vector(5 downto 0);
			signal f  : out std_logic_vector(7 downto 0)) ;
	end component;
	component hexa is
	  port(signal a  :  in std_logic_vector(3 downto 0);
			 signal f  : out std_logic_vector(6 downto 0)) ;
	end component;
	component counter_mod_seg is
		generic (n     : natural := 60;        
				  width : natural :=6
				  );
		port (signal reset_n :  in std_logic;
			  signal clk     :  in std_logic;
			  signal en      :  in std_logic;
			  signal q       : out std_logic_vector(width-1 downto 0)
			  );
	end component;
	component counter_mod_min is
		generic (n     : natural := 60;        
				  width : natural :=6
				  );
		port (signal reset_n :  in std_logic;
			  signal clk     :  in std_logic;
			  signal en      :  in std_logic;
			  signal sel     :  in std_logic_vector(1 downto 0);
			  signal q       : out std_logic_vector(width-1 downto 0)
			  );
	end component;
	component counter_mod_hor is
		generic (n     : natural := 2;        
				  width : natural :=2
				  );
		port (signal reset_n :  in std_logic;
			  signal clk     :  in std_logic;
			  signal en      :  in std_logic;
			  signal sel     :  in std_logic_vector(1 downto 0);
			  signal q       : out std_logic_vector(width-1 downto 0)
			  );
	end component;
	component comparador is
		generic(
			n: integer := 6
		);
		port(
			a : in std_logic_vector(n-1 downto 0);
			b : in std_logic_vector(n-1 downto 0);
			eq : out std_logic
		);
	end component;
end package;