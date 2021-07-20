library ieee;
use ieee.std_logic_1164.all;

entity cod4a2 is
	port(
		w: in std_logic_vector(3 downto 0);
		z: out std_logic;
		y: out std_logic_vector(1 downto 0));
		
end cod4a2;

architecture conc of cod4a2 is

begin
	
	process(w)
	begin
		if w(3) = '1' then
			y <= "11";
		elsif w(2) = '1' then
			y <= "10";
		elsif w(1) = '1' then
			y <= "01";
		elsif w(0) = '1' then
			y <= "00";
		else
			y <= "00";
		end if;
	end process;
	
	z <= '0' when w = "0000" else
		  '1';
	
end conc;