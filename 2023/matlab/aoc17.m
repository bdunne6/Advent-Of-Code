clear; close all;
input_path = fullfile(get_input_root,'day_17_sample.txt');
txt = read_txt(input_path);

%parse input
[m,s_pos,e_pos] = parse_input(txt);


p = struct();
p.rc = [1,1];
p.w = 0;
p.n_steps = 0;
p.dir = [1,0];

% search_paths(m,p)

ps = PathSearcher(m);

ps.search_paths(p);
imagesc(ps.wbest);

pb = ps.pbest{end};

% wc = diff(fliplr([pb.w]));
bpw = zeros(size(m));
% rc = [pb.rc];

% rca = cat(1,pb.rc);
for i1 = 1:numel(pb)
    rc = pb(i1).rc;
    bpw(rc(1),rc(2)) = pb(i1).w;
end
% figure;
% imagesc(bpw)
% hold on;
% plot(rca(:,2),rca(:,1),'.-');


p1 = ps.wbest(end);
disp(p1);

% search_paths(p,m);

% function search_paths(p,m)
% d = fliplr(p.dir);
% d = [d;-d];
% if p.n_steps < 3
%     d = [d;p.dir];
% end
% rc1 = p.rc + d;
% for i1 = 1:size(rc1,1)
%     i_v(i1) = (rc1(i1,1)<=size(m,1))&&(rc1(i1,2)<=size(m,2))&&(rc1(i1,1)>0)&&(rc1(i1,2)>0);
% end
% rc1 = rc1(i_v,:);
% d1 = d(i_v,:);
% 
% global t
% t(p.rc(1),p.rc(2)) = t(p.rc(1),p.rc(2))+1;
% figure(101)
% imagesc(t);
% drawnow();
% 
% for i1 = 1:size(rc1,1)
%     pn(i1) = p;
%     pn(i1).rc = rc1(i1,:);
%     pn(i1).loss = pn(i1).loss + m(rc1(i1,1),rc1(i1,2));
%     if all(d1(i1,:)==pn(i1).dir)
%         pn(i1).n_steps = pn(i1).n_steps + 1;
%     end
%     search_paths(pn(i1),m)
% end
% 
% end
% % function ind = gind()
% %
% % end
% 
function [m,s_pos,e_pos] = parse_input(txt)
lines = strsplit(txt,crlf);
x = cat(1,lines{:});
x = arrayfun(@(x)(x),x,'UniformOutput',false);
x = str2double(x);
m = x;
s_pos = [1,1];
e_pos = size(x);
end

% function g = construct_graph(m,g)
% if nargin < 2
%     g = digraph();
% end
% d = [-1,0;1,0;0,-1;0,1];
% s = [];
% t = [];
% for i1 = 1:size(m,1)
%     for i2 = 1:size(m,2)
%         moves = get_valid_moves(m,[i1,i2],d);
%         t_i2 = sub2ind(size(m),moves(:,1),moves(:,2));
%         s_i2 = sub2ind(size(m),i1,i2)*ones(size(t_i2,1),1);
%         s = cat(1,s,s_i2);
%         t = cat(1,t,t_i2);
%     end
% end
% g = digraph(s,t);
% end
%
% function vm = get_valid_moves(m,pos,d)
% vm = pos + d;
% i_v = false(size(vm,1),1);
% for i1 = 1:size(vm,1)
%     i_v(i1) = (vm(i1,1)<=size(m,1))&&(vm(i1,2)<=size(m,2))&&(vm(i1,1)>0)&&(vm(i1,2)>0);
% end
% vm = vm(i_v,:);
% end



