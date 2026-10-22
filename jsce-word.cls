%% jsce-word.cls
%% LaTeX class reproducing the layout of the Journal of Science and Engineering
%% (JScE) Word manuscript template (JScE_Format_new). Compile with pdfLaTeX.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jsce-word}[2026/10/22 v1.0 JScE manuscript (Word template layout)]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[a4paper,twocolumn]{article}

%% ---------------------------------------------------------------- fonts
\RequirePackage[T1]{fontenc}
\RequirePackage{newtxtext,newtxmath}
\RequirePackage{tinos}

%% --------------------------------------------------------------- layout
\RequirePackage[a4paper,top=25mm,bottom=69pt,left=57.6pt,right=55pt,
                columnsep=33.5pt,includefoot,footskip=39pt]{geometry}
\RequirePackage{etoolbox}
\RequirePackage{environ}
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage{array}
\RequirePackage{caption}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{stfloats}
\RequirePackage{flushend}
\RequirePackage[bottom]{footmisc}
\RequirePackage[round]{natbib}
\RequirePackage{url}
\RequirePackage[none]{hyphenat}

%% 10.5 pt text on a 13.9 pt line pitch (about 50 lines per page)
\renewcommand\normalsize{%
  \@setfontsize\normalsize{10.5}{13.9}%
  \abovedisplayskip 8pt plus 2pt minus 4pt
  \abovedisplayshortskip \z@ plus 3pt
  \belowdisplayshortskip 6pt plus 3pt minus 3pt
  \belowdisplayskip \abovedisplayskip
  \let\@listi\@listI}
\normalfont\normalsize

%% Word-style paragraphs: no indent, one blank line between paragraphs,
%% no hyphenation, no single first/last lines at a column break
\setlength{\parindent}{0pt}
\setlength{\parskip}{13.9pt}
\raggedbottom
\sloppy
\frenchspacing
\clubpenalty=10000
\widowpenalty=10000
\hbadness=10000
\spaceskip=2.625pt plus 3pt minus 0pt
\urlstyle{same}

%% ------------------------------------------------------------- headings
\titleformat{\section}{\fontsize{12}{15.8}\selectfont\bfseries}{\thesection.}{0.75em}{}
\titlespacing*{\section}{0pt}{14pt}{-1.2pt}
\titleformat{\subsection}{\fontsize{12}{15.8}\selectfont\bfseries}{\thesubsection.}{0.4em}{}
\titlespacing*{\subsection}{0pt}{1.5pt}{-13.2pt}
\titleformat{\subsubsection}{\normalsize\bfseries}{\thesubsubsection.}{0.4em}{}
\titlespacing*{\subsubsection}{0pt}{1.5pt}{-13.2pt}

%% ------------------------------------------------------------- captions
\DeclareCaptionLabelSeparator{twospace}{\ \ }
\captionsetup{font=normalsize,justification=centering,singlelinecheck=false}
\captionsetup[figure]{name=Fig.,labelsep=twospace,skip=25.5pt}
\captionsetup[table]{name=Table,labelsep=colon,position=top,skip=13.6pt}
\setlength{\intextsep}{0pt}

%% --------------------------------------------------------------- footer
\def\@runningauthor{Author}
\newcommand*{\runningauthor}[1]{\gdef\@runningauthor{#1}}
\pagestyle{fancy}
\fancyhf{}
\fancyfoot[L]{\hspace*{37.5pt}JScE}
\fancyfoot[R]{\ifx\@runningauthor\@empty\else\@runningauthor\ \ \ \fi\thepage\hspace*{37.4pt}}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0.5pt}

%% ---------------------------------------------------------- title block
\def\@affiliation{}
\def\@keywords{}
\def\@corresponding{}
\def\@jsceabstract{}
\newcommand{\affiliation}[1]{\gdef\@affiliation{#1}}
\newcommand{\keywords}[1]{\gdef\@keywords{#1}}
\newcommand{\corresponding}[1]{\gdef\@corresponding{#1}}
\RenewEnviron{abstract}{\xdef\@jsceabstract{\unexpanded\expandafter{\BODY}}}

\renewcommand{\footnoterule}{\kern-3pt\moveleft5.4pt\vbox{\hrule width 233.7pt height 0.5pt}\kern 2.6pt}
\newcommand{\jsce@note}[1]{%
  \begingroup
    \long\def\@makefntext##1{\noindent\fontsize{9}{11.9}\selectfont\spaceskip=2.25pt plus 2.5pt ##1}%
    \renewcommand\thefootnote{}%
    \footnotetext{#1}%
  \endgroup}

\renewcommand{\maketitle}{%
  \twocolumn[{%
    \setlength{\parskip}{0pt}%
    \vspace*{4pt}%
    {\centering
      {\fontsize{12}{15.8}\selectfont\bfseries\@title\par}%
      \vspace{14.1pt}%
      {\fontsize{12}{15.8}\selectfont\bfseries\@author\par}%
      \vspace{14.6pt}%
      {\itshape\@affiliation\par}}%
    \vspace{4.5pt}%
    \noindent\hspace*{-5.4pt}\rule{\dimexpr\textwidth-0.7pt\relax}{0.5pt}\par
    \vspace{23.4pt}%
    \noindent{\fontsize{12}{15.8}\selectfont\bfseries Abstract\par}%
    \vspace{0.6pt}%
    \noindent\@jsceabstract\par
    \vspace{13.9pt}%
    \noindent\textbf{Keywords:}\ \ \@keywords\par
    \vspace{4.7pt}%
    \noindent\hspace*{-6.1pt}\rule{\textwidth}{0.5pt}\par
    \vspace{27.9pt}%
  }]%
  \ifx\@corresponding\@empty\else
    \jsce@note{*Corresponding author: \@corresponding\\
      (Received:\ \ Accepted: to be filled by the Editorial Board)}%
  \fi}

%% ----------------------------------------------------------- references
\setlength{\bibsep}{11.9pt}
\setlength{\bibhang}{0pt}
\renewcommand{\bibfont}{\fontsize{9}{11.9}\selectfont\spaceskip=2.25pt plus 2.5pt\relax
  \interlinepenalty=10000
  \def\@listi{\leftmargin\leftmargini\parsep\z@\topsep\z@\partopsep\z@\itemsep\z@}}
\renewcommand{\bibsection}{{\fontsize{12}{15.8}\selectfont\bfseries References\par}\vspace{-12.7pt}}
\AfterEndEnvironment{thebibliography}{\vspace{9.8pt}}

\endinput
