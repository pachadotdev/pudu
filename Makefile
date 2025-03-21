clean:
	@Rscript -e 'devtools::clean_dll()'
	@Rscript -e 'devtools::clean_dll("pudutest")'

test:
	@echo "Testing R code"
	@Rscript -e 'devtools::document()'
	@Rscript -e 'devtools::load_all(); devtools::test()'
	@echo "Testing C++ code"
	@Rscript -e 'devtools::load_all("pudutest"); devtools::test("pudutest")'

check:
	@echo "Local"
	@Rscript -e 'devtools::document()'
	@Rscript -e 'devtools::check(); devtools::check("pudutest")'
	# this says "SSL certificate problem: self-signed certificate"
	# @echo "RHub"
	# @Rscript -e 'devtools::check_rhub()'
	# @echo "Win Builder"
	# @Rscript -e 'devtools::check_win_release()'
	# @Rscript -e 'devtools::check_win_devel()'

site:
	@Rscript -e 'devtools::document()'
	@Rscript -e 'pkgdown::build_site()'

install:
	@Rscript -e 'devtools::install()'

clang_format=`which clang-format-14`

format: $(shell find . -name '*.h') $(shell find . -name '*.hpp') $(shell find . -name '*.cpp')
	@${clang_format} -i $?
