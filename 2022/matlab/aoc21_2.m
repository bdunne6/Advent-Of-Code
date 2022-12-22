input_path = fullfile(get_input_root,'day_21_sample.txt');
txt = read_txt(input_path);
lines = strsplit(txt,'\r\n');

x = cellfun(@(x)(strsplit(x,': ')),lines,'UniformOutput' ,false);
x = cat(1,x{:});
%x = readcell(input_path,"Delimiter",':',"TextType",'char');

i_root = strcmp(x(:,1),'root');
i_humn = strcmp(x(:,1),'humn');

m0 = containers.Map(x(:,1),x(:,2));
m = containers.Map(x(:,1),x(:,2));
k = m.keys;
v = m.values;

rm = containers.Map();
%
rm = cell(size(v));
for i1 = 1:numel(k)
    i_c = find(contains(m.values,k{i1}));
    for i2 = 1:numel(i_c)
        if isempty(rm{i_c(i2)})
            rm{i_c(i2)} = k(i1);
        else
            rm{i_c(i2)} = [rm{i_c(i2)},k(i1)];
        end
    end
end

letters = num2cell(char(97:122));

e_r0 = x{i_root,2};

% v_r = regexp(e_r0, '[\*\+\-\/]', 'split');
e_r1 = e_r0;
%x = x(~i_root,:);
x1 = x;

i_numeric = ~isnan(cellfun(@str2double,m.values));



while any(~i_numeric)
    for i1 = 1:numel(v)
        %         if isnumeric(m(k{i1}))
        if i_numeric(i1)
            for i2 = 1:numel(rm)
                if ~isempty(rm{i2})
                    i_c = strcmp(rm{i2},k{i1});
                    
                    
                    if any(i_c)
                        i_c = strcmp(rm{i2},k{i1});
                        rm{i2}(i_c) = [];
                        
                        if strcmp(k{i1},'humn')
                            rval = '@';
                        else
                            rval = ['(',m(k{i1}),')'];
                        end
                        ei1 = strrep(m(k{i2}),k{i1},rval);
                        
                        if ~contains(ei1,letters)
                            i_numeric(i2) = true;
                        end
                        
                        if ~contains(ei1,[letters,{'@'}])
                            eval(['tmp = ',ei1,';']);
                            m(k{i2}) = num2str(tmp);
                            %i_numeric(i2) = true;
                            %i_numeric
                        else
                            %i_numeric(i1) = false;
                            m(k{i2}) = ei1;
                        end
                    end
                end
            end
        end
    end
    sum(~i_numeric)
end


rp = regexp(m0('root'), '[\*\+\-\/]', 'split');
rp1 = strip(rp{1});
rp2 = strip(rp{2});
ex = strrep(m(rp1),'@','x');

eval(['f = @(x) (', ex ,');'])
m(rp2)

t = -1000:1000;
yt = f(t);
figure;
plot(yt)


