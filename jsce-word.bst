%% jsce-word.bst
%% Author-year BibTeX style for the jsce-word class (use with natbib).
%% Reference format follows the JScE manuscript template, e.g.
%%   Khadka, S.R. & Bhandari, P.P. (2017). Title. Journal, 14(1), 27-34.
%% References are sorted alphabetically by first author, then year.

ENTRY
  { address author booktitle doi edition editor howpublished institution
    journal key note number organization pages publisher school title type
    url urldate volume year eid }
  {}
  { label extra.label sort.label }

INTEGERS { output.state before.all mid.sentence after.sentence }

FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
}

STRINGS { s t }

FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state before.all =
        'write$
        { add.period$ " " * write$ }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}

FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}

FUNCTION {new.sentence}
{ output.state before.all =
    'skip$
    { after.sentence 'output.state := }
  if$
}

FUNCTION {fin.entry}
{ add.period$
  write$
  doi empty$
    'skip$
    { " \url{https://doi.org/" doi * "}" * write$ }
  if$
  newline$
}

FUNCTION {not}
{ { #0 }
    { #1 }
  if$
}

FUNCTION {and}
{ 'skip$
    { pop$ #0 }
  if$
}

FUNCTION {emphasize}
{ duplicate$ empty$
    { pop$ "" }
    { "\textit{" swap$ * "}" * }
  if$
}

FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}

INTEGERS { nameptr namesleft numnames }

FUNCTION {format.names}
{ 's :=
  #1 'nameptr :=
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{vv~}{ll}{, f{.}.}{, jj}" format.name$ 't :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { t "others" =
                { " et~al." * }
                { " \& " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {format.year}
{ year empty$
    { "n.d." }
    { year }
  if$
  extra.label *
}

FUNCTION {author.year.title}
{ author empty$
    { title output
      new.sentence
      "(" format.year * ")" * output
    }
    { author format.names " (" * format.year * ")" * output
      new.sentence
      title output
    }
  if$
}

FUNCTION {author.year.btitle}
{ author empty$
    { title emphasize output
      new.sentence
      "(" format.year * ")" * output
    }
    { author format.names " (" * format.year * ")" * output
      new.sentence
      title emphasize output
    }
  if$
}

FUNCTION {format.journal}
{ journal emphasize
  volume empty$
    'skip$
    { ", " * volume emphasize *
      number empty$
        'skip$
        { "(" * number * ")" * }
      if$
    }
  if$
  pages empty$
    { eid empty$
        'skip$
        { ", " * eid * }
      if$
    }
    { ", " * pages * }
  if$
}

FUNCTION {format.publisher}
{ publisher empty$
    { address field.or.null }
    { address empty$
        { publisher }
        { address ": " * publisher * }
      if$
    }
  if$
}

FUNCTION {format.url}
{ url empty$
    { "" }
    { urldate empty$
        { "Retrieved from \url{" url * "}" * }
        { "Retrieved " urldate * ", from \url{" * url * "}" * }
      if$
    }
  if$
}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem[" write$
  label write$
  ")]{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}

FUNCTION {article}
{ output.bibitem
  author.year.title
  new.sentence
  format.journal output
  new.sentence
  note output
  fin.entry
}

FUNCTION {book}
{ output.bibitem
  author empty$
    { editor empty$
        'author.year.btitle
        { editor format.names " (Ed.) (" * format.year * ")" * output
          new.sentence
          title emphasize output
        }
      if$
    }
    'author.year.btitle
  if$
  edition empty$
    'skip$
    { "(" edition * " ed.)" * output }
  if$
  new.sentence
  format.publisher output
  new.sentence
  note output
  fin.entry
}

FUNCTION {inproceedings}
{ output.bibitem
  author.year.title
  new.sentence
  booktitle emphasize
  pages empty$
    'skip$
    { ", (pp.~" * pages * ")" * }
  if$
  output
  new.sentence
  format.publisher output
  new.sentence
  note output
  fin.entry
}

FUNCTION {conference} { inproceedings }

FUNCTION {incollection}
{ output.bibitem
  author.year.title
  new.sentence
  "In "
  editor empty$
    'skip$
    { editor format.names *
      editor num.names$ #1 >
        { " (Eds.), " * }
        { " (Ed.), " * }
      if$
    }
  if$
  booktitle emphasize *
  pages empty$
    'skip$
    { " (pp.~" * pages * ")" * }
  if$
  output
  new.sentence
  format.publisher output
  new.sentence
  note output
  fin.entry
}

FUNCTION {inbook} { incollection }

FUNCTION {thesis.type}
{ 't :=
  type empty$
    { t }
    { type }
  if$
  school empty$
    'skip$
    { ", " * school * }
  if$
  address empty$
    'skip$
    { ", " * address * }
  if$
  emphasize
}

FUNCTION {phdthesis}
{ output.bibitem
  author.year.title
  new.sentence
  "PhD Thesis" thesis.type output
  new.sentence
  note output
  fin.entry
}

FUNCTION {mastersthesis}
{ output.bibitem
  author.year.title
  new.sentence
  "Master's Thesis" thesis.type output
  new.sentence
  note output
  fin.entry
}

FUNCTION {techreport}
{ output.bibitem
  author.year.title
  new.sentence
  type empty$
    { "Technical Report" }
    { type }
  if$
  number empty$
    'skip$
    { " No.~" * number * }
  if$
  institution empty$
    'skip$
    { ", " * institution * }
  if$
  output
  new.sentence
  note output
  fin.entry
}

FUNCTION {misc}
{ output.bibitem
  author.year.title
  new.sentence
  howpublished output
  new.sentence
  note output
  new.sentence
  format.url output
  fin.entry
}

FUNCTION {online} { misc }
FUNCTION {booklet} { misc }
FUNCTION {manual} { misc }
FUNCTION {unpublished} { misc }
FUNCTION {default.type} { misc }

MACRO {jan} {"January"}
MACRO {feb} {"February"}
MACRO {mar} {"March"}
MACRO {apr} {"April"}
MACRO {may} {"May"}
MACRO {jun} {"June"}
MACRO {jul} {"July"}
MACRO {aug} {"August"}
MACRO {sep} {"September"}
MACRO {oct} {"October"}
MACRO {nov} {"November"}
MACRO {dec} {"December"}

READ

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

FUNCTION {format.lab.names}
{ 's :=
  s #1 "{vv~}{ll}" format.name$
  s num.names$ duplicate$
  #2 >
    { pop$ " et~al." * }
    { #2 <
        'skip$
        { s #2 "{ff }{vv }{ll}{ jj}" format.name$ "others" =
            { " et~al." * }
            { " and " * s #2 "{vv~}{ll}" format.name$ * }
          if$
        }
      if$
    }
  if$
}

FUNCTION {calc.label}
{ author empty$
    { editor empty$
        { key empty$
            { title field.or.null }
            { key }
          if$
        }
        { editor format.lab.names }
      if$
    }
    { author format.lab.names }
  if$
  "(" *
  year empty$
    { "n.d." }
    { year }
  if$
  *
  'label :=
}

FUNCTION {sort.format.names}
{ 's :=
  #1 'nameptr :=
  ""
  s num.names$ 'numnames :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { nameptr #1 >
        { "   " * }
        'skip$
      if$
      s nameptr "{vv{ } }{ll{ }}{  f{ }}{  jj{ }}" format.name$ 't :=
      nameptr numnames = t "others" = and
        { "et al" * }
        { t sortify * }
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$
}

FUNCTION {presort}
{ calc.label
  author empty$
    { editor empty$
        { title field.or.null sortify }
        { editor sort.format.names }
      if$
    }
    { author sort.format.names }
  if$
  "    " *
  year field.or.null sortify *
  "    " *
  title field.or.null sortify *
  #1 entry.max$ substring$
  'sort.key$ :=
}

ITERATE {presort}

SORT

STRINGS { last.label next.extra }

INTEGERS { last.extra.num number.label }

FUNCTION {initialize.extra.label.stuff}
{ #0 int.to.chr$ 'last.label :=
  "" 'next.extra :=
  #0 'last.extra.num :=
  #0 'number.label :=
}

FUNCTION {forward.pass}
{ last.label label =
    { last.extra.num #1 + 'last.extra.num :=
      last.extra.num int.to.chr$ 'extra.label :=
    }
    { "a" chr.to.int$ 'last.extra.num :=
      "" 'extra.label :=
      label 'last.label :=
    }
  if$
  number.label #1 + 'number.label :=
}

FUNCTION {reverse.pass}
{ next.extra "b" =
    { "a" 'extra.label := }
    'skip$
  if$
  extra.label 'next.extra :=
  extra.label
  duplicate$ empty$
    'skip$
    { "{\natexlab{" swap$ * "}}" * }
  if$
  'extra.label :=
  label extra.label * 'label :=
}

EXECUTE {initialize.extra.label.stuff}

ITERATE {forward.pass}

REVERSE {reverse.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{" number.label int.to.str$ * "}" * write$
  newline$
  "\providecommand{\natexlab}[1]{#1}" write$
  newline$
  "\providecommand{\url}[1]{\texttt{#1}}" write$
  newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$
  newline$
}

EXECUTE {end.bib}
