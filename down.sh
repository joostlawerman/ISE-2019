find ./migrations -type f -name "*.sql" ! -name "*.test.sql" | sort | xargs -I{} awk 'FNR==1{print ""}1' {} | sed -n "/-- +migrate Down/,/;/p" | sed "s/-- +migrate Down/GO/g" | sed "s/;/\ /g" > out/down.master.sql