\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kththesis}[2018/04/26 KTH Thesis formatting]

\newif\ifinswedish
\DeclareOption{english}{}
\DeclareOption{swedish}{\inswedishtrue}

\newif\ifgfivepaper
\DeclareOption{a4paper}{}
\DeclareOption{g5paper}{\gfivepapertrue}

\newif\ifbachelor
\DeclareOption{bachelor}{\bachelortrue}
\DeclareOption{master}{}

%% Send any unknown option to the report class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

\ProcessOptions\relax

\ifgfivepaper
  \LoadClass[10pt]{report}
\else
  \LoadClass[12pt]{report}
\fi

% Make it possible to conditionally depend on the TeX-engine used
\RequirePackage{ifxetex}
\RequirePackage{ifluatex}
\newif\ifxeorlua
\ifxetex\xeorluatrue\fi
\ifluatex\xeorluatrue\fi

%% Load other packages

\ifxeorlua
  \RequirePackage{polyglossia}
  \ifinswedish
    \setmainlanguage{swedish}
    \setotherlanguage{english}
  \else
    \setmainlanguage{english}
    \setotherlanguage{swedish}
  \fi
\else
  \RequirePackage[utf8]{inputenc}
  \RequirePackage[swedish,english]{babel}
\fi

\ifgfivepaper
\RequirePackage[paperwidth=169mm,paperheight=239mm,twoside,
  top=30mm,bottom=30mm,inner=36mm,outer=18mm,
  headsep=10mm,headheight=5mm]{geometry} % Set paper and contents dimensions
\else
\RequirePackage[a4paper,twoside,
  top=37mm,bottom=50mm,inner=45mm,outer=35mm,
  headsep=15mm,headheight=6mm,footskip=25mm]{geometry} % Set paper and contents dimensions
\fi
\RequirePackage{fancyhdr} % Take control of headers and footers
\RequirePackage{emptypage} % Supress page numbers on otherwise empty pages

\RequirePackage{pdfpages} % Used to include the preformatted KTH cover pages

\RequirePackage{titlesec} % Redefine the appearance of headers
% === Patch to circumvent a bug in the titlesec package version 2.10.1
\@ifpackagelater{titlesec}{2016/03/21}{%
 % Package titlesec is on version 2.10.2 or higher, nothing to do %
}{%
 % Check if package titlesec is on version 2.10.1 %
 \@ifpackagelater{titlesec}{2016/03/15}{%
  % Package titlesec on version 2.10.1, patch accordingly %
  \RequirePackage{etoolbox}%
  \patchcmd{\ttlh@hang}{\parindent\z@}{\parindent\z@\leavevmode}{}{}%
  \patchcmd{\ttlh@hang}{\noindent}{}{}{}%
 }{%
  % Package titlsecon is on version 2.10.0 or lower, nothing to do %
 }%
}
% === End ot titlesec patch

\ifxeorlua
  \RequirePackage{fontspec}
  \defaultfontfeatures{Ligatures={TeX}} % This enables TeX style ligatures such as ---, '', ``, and so on
  \setmainfont{TeX Gyre Termes}  %% Times like font
  \setsansfont{TeX Gyre Heros}   %% Helvetica like font
  \setmonofont{TeX Gyre Cursor}  %% Courier like font
\else
  \RequirePackage[T1]{fontenc}
  \RequirePackage{tgtermes}
  \RequirePackage{tgheros}
  \RequirePackage{tgcursor}
\fi

% Set up the header and footer
\fancyhead{}
\fancyhead[RO]{\sffamily\small\leftmark\qquad\thepage}
\fancyhead[LE]{\sffamily\small\thepage\qquad\leftmark}
\fancyfoot{}
\renewcommand{\headrulewidth}{0pt}
\pagestyle{fancy}

% Add 5% extra linespacing
\linespread{1.05}

% Set the proper format for the headers
\titleformat{\chapter}[display]
  {\normalfont\sffamily\huge\bfseries}
  {\chaptertitlename\ \thechapter}{20pt}{\Huge}
\titleformat{\section}
  {\normalfont\sffamily\Large\bfseries}
  {\thesection}{1em}{}
\titleformat{\subsection}
  {\normalfont\sffamily\large\bfseries}
  {\thesubsection}{1em}{}

\renewenvironment{abstract}{\section*{\abstractname}}{\clearpage}

% Define commands for setting the user definable parts of the title page
\newcommand{\supervisor}[1]{\def\@supervisor{#1}}
\newcommand{\examiner}[1]{\def\@examiner{#1}}
\let\@secondauthor\@empty
\newcommand{\secondauthor}[1]{\def\@secondauthor{#1}}
\let\@subtitle\@empty
\newcommand{\subtitle}[1]{\def\@subtitle{#1}}
\let\@alttitle\@empty
\newcommand{\alttitle}[1]{\def\@alttitle{#1}}
\let\@hostcompany\@empty
\newcommand{\hostcompany}[1]{\def\@hostcompany{#1}}
\let\@hostorganization\@empty
\newcommand{\hostorganization}[1]{\def\@hostorganization{#1}}
\let\@email\@empty
\newcommand{\email}[1]{\def\@email{#1}}
\let\@school\@empty
\newcommand{\school}[1]{\def\@school{#1}}
\let\@programme\@empty
\newcommand{\programme}[1]{\def\@programme{#1}}
\let\@kthcover\@empty
\newcommand{\kthcover}[1]{\def\@kthcover{#1}}

% Command to print out the standardized title page
\renewcommand{\titlepage}{
\ifgfivepaper
  \newgeometry{top=65mm,bottom=30mm,left=62mm,right=18mm}
\else
  \newgeometry{top=65mm,bottom=30mm,left=50mm,right=35mm}
\fi
\thispagestyle{empty}
\ifinswedish\selectlanguage{swedish}\fi
\begin{huge}
  \begin{flushleft}
    \noindent\sffamily\bfseries \@title \par
  \end{flushleft}
\end{huge}
\ifx\@subtitle\@empty\relax
\else
\begin{Large}
  \vspace{1ex}
  \begin{flushleft}
    \noindent\sffamily\bfseries \@subtitle \par
  \end{flushleft}
\end{Large}
\fi

\vspace{10mm}
\begin{large}
  \begin{flushleft}
    \sffamily
    \expandafter\MakeUppercase\expandafter\@author \par
    \ifx\@secondauthor\@empty\relax
    \else\vspace{1ex}\expandafter\MakeUppercase\expandafter\@secondauthor \par
    \fi
  \end{flushleft}
\end{large}

\vfill

\begin{flushleft}
  \sffamily
  \ifinswedish
    \@programme\\
    \ifx\@date\@empty\relax\else Datum: \@date\\\fi
    Handledare: \@supervisor\\
    Examinator: \@examiner\\
    \@school\\
    \ifx\@hostcompany\@empty\relax\else Uppdragsgivare: \@hostcompany\\\fi
    \ifx\@hostorganization\@empty\relax\else Uppdragsgivare: \@hostorganization\\\fi
    \ifx\@alttitle\empty\relax\else Engelsk titel: %
    \begin{otherlanguage}{english}\sffamily\@alttitle\end{otherlanguage}\\\fi
  \else
    \@programme\\
    \ifx\@date\@empty\relax\else Date: \@date\\\fi
    Supervisor: \@supervisor\\
    Examiner: \@examiner\\
    \@school\\
    \ifx\@hostcompany\@empty\relax\else Host company: \@hostcompany\\\fi
    \ifx\@hostorganization\@empty\relax\else Host organization: \@hostorganization\\\fi
    \ifx\@alttitle\empty\relax\else Swedish title: %
    \begin{otherlanguage}{swedish}\sffamily\@alttitle\end{otherlanguage}\\\fi
  \fi
\end{flushleft}
\restoregeometry
\cleardoublepage
}


\newcommand{\frontmatter}{
  \ifx\@kthcover\@empty\relax\else \includepdf[pages={1}]{\@kthcover}\fi
  \pagenumbering{roman}
  \setcounter{page}{1}
}

\newcommand{\mainmatter}{
  \cleardoublepage
  \pagenumbering{arabic}
}

\newcommand{\tailmatter}{
  \ifx\@kthcover\@empty\relax\else
  \cleardoublepage
  \includepdf[pages={2}]{\@kthcover}\fi
}

\endinput
