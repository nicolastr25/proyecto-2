library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_movimientos_j is
	generic (n     : natural := 255;        
           width : natural :=8
			  );
	port (signal reset_n :  in std_logic;
        signal clk     :  in std_logic;
        signal en      :  in std_logic;
        signal q       : out std_logic_vector(width-1 downto 0)
		  );
end counter_movimientos_j;

architecture structural_5 of counter_movimientos_j is

  signal q_reg   : unsigned(width-1 downto 0);
  signal q_next  : unsigned(width-1 downto 0);

  
begin
  
  seq: process(reset_n,clk)
  begin
    if (reset_n = '0') then
      q_reg <= "00000000";
    elsif rising_edge(clk) then
      q_reg <= q_next;  
    end if;
  end process seq;

  comb: process(en, q_reg)
  begin
    if (en = '1') then
	  --if (q_reg = to_unsigned(n-1,q_reg'length)) then
	  if (q_reg = "11111111" ) then
	    q_next <= "00000000";
	  else	
	    q_next <= q_reg + 1;
	  end if; 	
	else
	  q_next <= q_reg;
    end if;
  end process comb;
  q <= std_logic_vector(q_reg); 
  
  
  
end structural_5;