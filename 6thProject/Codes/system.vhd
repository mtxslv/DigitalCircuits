-- Comunication System
-- for more info, go to: github.com/mtxslv/DigitalCircuits
-- Please, make sure the files X.vhd and Ynewtriala.vhd are in the project directory.

entity system is
  port( CLK, global_load: bit;
        K: bit_vector(1 downto 0);
        global_A: in bit_vector(3 downto 0);
        global_Z: out bit_vector(3 downto 0));
end system;

architecture system_ckt of system is

-- receiver module
component X is
  port( Z: out bit_vector(3 downto 0);
        clock, clear: in bit;
        q_input: in bit);
end component;

-- sender module
component Y is
  port( A: in bit_vector(3 downto 0);
        clock, clear, load: in bit;
        q_output: out bit);
end component;     

-- auxiliar bit, which gets the information from one module to another
signal q_aux: bit;
-- auxiliar bit_vector, which collects the final message
signal Z_aux: bit_vector(3 downto 0);

begin
  
  lbl_sender: Y port map(clock => CLK,
                         clear => K(0),
			                   load => global_load,
                         A(3) => global_A(3),
                         A(2) => global_A(2),
                         A(1) => global_A(1),
                         A(0) => global_A(0),
                         q_output => q_aux);
  lbl_receiver: X port map(clock => CLK,
                           clear => K(1),
                           q_input => q_aux,
                           Z(3) => Z_aux(3),
                           Z(2) => Z_aux(2),
                           Z(1) => Z_aux(1),
                           Z(0) => Z_aux(0));
  global_Z(3) <= Z_aux(3);
  global_Z(2) <= Z_aux(2);                      
  global_Z(1) <= Z_aux(1);                      
  global_Z(0) <= Z_aux(0);                                               

end system_ckt;
