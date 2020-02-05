run_tf_by_chunk=function (urls = url_links, keyword_list = c("Fiscal outcomes", 
                                                             "Currency_crisis"),
                          extract_number = 1,
                          delete_pdfs = T,
                          rm_short_docs=F,
                          min_words=100,
                          parrallel=T) 
{
  
  # run the term frequency matrix on the list of urls provided as parameter.
  # The function download the pdf, create the corpus and generate the term
  # frequency matrix, to avoid storage limitation the function deleate
  # original pdf files
  
  # parameters: urls: a dataframe containing two columns: name_file and pdf
  # that respectively provid the name that will be given to the file
  # downloaded and pdf that contains the url of the pdf keyword_list: one of
  # the element of the list provided by key_word_crisis() extract_number: a
  # number that will be ued as a suffix for the name of the corpus and the
  # name of the tf matrix delete_pdfs: T/F, set to T it will delete the folder
  # containing the original pdf, usefull option when the number of pdf is very
  # large and the size of the folder start to be very large
  
  path = "temp"
  path_pdf_files = paste0(path, "/files")
  path_corpus = paste0(path, "/corpus")
  path_tf = paste0(path, "/tf")
  
  dir.create(path)
  dir.create(path_pdf_files)
  dir.create(path_corpus)
  dir.create(path_tf)
  
  # download the files
  pdf_from_url(urls, path_pdf_files, overwrite = F)
  # transform pdf to character and store in list
  corpus = aggregate_corpus(path_pdf_files,only_files=T)
  
  # remove documents with less than specified number of words
  if(rm_short_docs){
    cat(crayon::blue(paste0("\n Remove from corpus the documents with less than ",min_words," words\n")))
    N_char_corpus=sapply(1:length(corpus),function(x){
      sum(stri_count_words(corpus[[x]]))
    })
    names(N_char_corpus)=names(corpus)
    N_char_corpus=data.frame(N_char_corpus)
    N_char_corpus$file=names(corpus)
    N_char_corpus=N_char_corpus %>% filter(N_char_corpus>=min_words)
    corpus=corpus[N_char_corpus$file]
  }
  
  # save corpus
  save(corpus, file = paste0(path_corpus, "/corpus_", extract_number, 
                             ".RData"))
  
  # delete folder with pdf after consolidating
  cat(crayon::blue("delete folder with pdf \n"))
  if (delete_pdfs) {
    unlink(path_pdf_files, recursive = T)
  }
  # run the term frequency matrix
  dt = run_tf(corpus_path = paste0(path_corpus, "/corpus_", 
                                   extract_number, ".RData"), type_lexicon = "words", keyword_list = keyword_list, 
              export_path = path_tf, parrallel = parrallel)
  
  file.rename(from = paste0(path_tf, "/tf_crisis_words.RData"), 
              to = paste0(path_tf, "/tf_crisis_words_", extract_number, 
                          ".RData"))
}