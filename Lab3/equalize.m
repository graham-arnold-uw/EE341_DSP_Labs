%Lab3 EE341
%Group members: Graham Arnold, Ting-Yu(Jacky) Wang
%Group member contribution: Each group member contributed equally to this
%script, the script was written collaboratively with both members working
%on the same task.

function sum = equalize(G1, G2, G3, G4, a1, a2, a3, a4, b1, b2, b3, b4, y)

lpf = filter(b1, a1, y);
bpf1 = filter(b2, a2, y);
bpf2 = filter(b3, a3, y);
hpf = filter(b4, a4, y);

sum = (G1 .* lpf) + (G2 .* bpf1) + (G3 .* bpf2) + (G4 .* hpf);

end