library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity mux_4a1 is
 port(
 
     A,B,C,D : in std_logic_vector(6 downto 0);
     sel: in std_logic_vector(1 downto 0);
     display: out std_logic_vector(6 downto 0)
  );
end mux_4a1;
 
architecture bhv of mux_4a1 is
begin
with sel select 
	display <= A when "00",
				  B when "01",
			     C when "10", 
				  D when "11",
				 "-------" when others; 
		  
end bhv;