library ieee;
use ieee.std_logic_1164.all;

entity comparador3 is
	generic(
		n: integer := 8
	);
	port(
		a : in std_logic_vector(n-1 downto 0);
		b : in std_logic_vector(n-1 downto 0);
		eq : out std_logic
	);
end comparador3;

architecture modular2 of comparador3 is
begin
	eq <= '1' when a > b else
			'0';
end modular2;