find ./migrations -type f -name "*.sql" ! -name "*.test.sql" | sort | xargs -I{} awk 'FNR==1{print ""}1' {} | sed -n "/-- +migrate Up/,/;/p" | sed "s/-- +migrate Up/GO/g" | sed "s/;/\ /g" > out/up.master.sql