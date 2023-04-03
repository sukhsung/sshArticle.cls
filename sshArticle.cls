\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{sshArticle}[2023/04/02 article class by Suk Hyun Sung]

\RequirePackage{xcolor}
\definecolor{pageColor}{HTML}{FFFFFF}
\definecolor{textColor}{HTML}{000000}
\definecolor{linkColor}{HTML}{4843D1}
\LoadClass[twoside]{article}
%% Choose Main vs SI
\DeclareOption{main}{%
    \def\maketitle{\makeMaintitle{}}
    \def\sectiongap{-3pt}
    \def\subsectiongap{-3pt}
    \def\sectionFontSize{\normalsize}
    \PassOptionsToClass{twocolumn}{article}
    \setlength{\columnsep}{15pt}
}

\DeclareOption{SI}{%
    \def\maketitle{\makeSItitle{}}
    \def\sectiongap{0pt}
    \def\sectionFontSize{\large}
    \PassOptionsToClass{onecolumn}{article}
}

\DeclareOption{dark}{%
    \definecolor{pageColor}{HTML}{1B1A1C}
    \definecolor{textColor}{HTML}{AAAAAA}
    \definecolor{linkColor}{HTML}{FF8080}
}

\ProcessOptions\relax


%% Formatting
\RequirePackage[letterpaper, left=0.6in,right=0.5in, top=0.5in, bottom=0.8in,headsep=0.05in]{geometry}
\RequirePackage[colorlinks=true, allcolors=linkColor]{hyperref}
\RequirePackage{setspace}
\setlength{\parskip}{6pt}
\raggedbottom
\tolerance=6000
\color{textColor}
\pagecolor{pageColor}

%% Fonts
\RequirePackage{fontspec}
% \setmainfont{TeX Gyre Termes}
\setmainfont{TeX Gyre Pagella}
\setsansfont{TeX Gyre Heros}

%% Header Footer
\RequirePackage{fancyhdr}
\newcommand{\firstAuthorLastNameString}{}
\newcommand{\firstAuthorLastName}[1]{\renewcommand{\firstAuthorLastNameString}{#1}}

\def\runFancy{%
    \pagestyle{fancy}
    \fancyfoot[LE]{\sffamily\small \firstAuthorLastNameString~et al., \thepage}
    \fancyfoot[RE]{\sffamily\small \titleString}
    \fancyfoot[RO]{\sffamily\small \firstAuthorLastNameString~et al., \thepage}
    \fancyfoot[LO]{\sffamily\small \titleString}
    \fancyfoot[C]{}
    \fancyhead{}
    \renewcommand{\headrulewidth}{0pt}
}


%% Authors
\newcommand{\authorList}{}
\newcommand{\authorListSI}{}

\newcounter{numAuthors}

\newcommand{\addToAuthorList}[1]{\stepcounter{numAuthors}\listadd\authorList{#1}}
\newcommand{\addToAuthorListSI}[1]{\listadd\authorListSI{#1}}

\renewcommand{\author}[2][]{%
    \addToAuthorList{#2\textsuperscript{#1}}%
    \addToAuthorListSI{#2}%
}

\def\doAuthor#1{%
 \ifnumequal{\value{numAuthors}}{1}{%
  and #1}{\addtocounter{numAuthors}{-1}#1,~}%   
}

\def\doAuthorSingle#1{%
    {\addtocounter{numAuthors}{-1}#1,~}%   
}

\def\authors{%
\ifnumequal{\value{numAuthors}}{1}%
    {\forlistloop{\doAuthorSingle}{\authorList}}%
    {\forlistloop{\doAuthor}{\authorList}}%
}

\def\authorsSI{%
\ifnumequal{\value{numAuthors}}{1}%
    {\forlistloop{\doAuthorSingle}{\authorListSI}}%
    {\forlistloop{\doAuthor}{\authorListSI}}%
}

%% Affiliations
\newcommand{\affList}{}
\newcounter{numAffs}
\newcommand{\addToAffList}[1]{\stepcounter{numAffs}\listadd\affList{#1}}
\newcommand{\affil}[2][]{\addToAffList{\textsuperscript{#1}#2}}

\def\doAff#1{%
 \ifnumequal{\value{numAffs}}{1}{%
  #1}{\addtocounter{numAffs}{-1}#1.~}%   
}

\def\affs{\forlistloop{\doAff}{\affList}}

%% Abstract
\newcommand{\abstractString}{}
\renewcommand{\abstract}[1]{\renewcommand{\abstractString}{#1}}

%% maketitle
\makeatletter
\def\makeMaintitle{\sffamily%
    \twocolumn[
      \begin{@twocolumnfalse}
        \noindent\textbf{\Large\@title}\par\vspace{12pt}%
        \noindent\textbf{\normalsize\authors}\par\vspace{12pt}%
        \noindent{\scriptsize\affs}\par\vspace{24pt}%
        \centering\parbox{7in}{\noindent\textbf{\normalsize\abstractString}}\par\vspace{24pt}
      \end{@twocolumnfalse}]
    \rmfamily%
    \newcommand{\titleString}{\@title}%
    \runFancy%
    \noindent}
\makeatother

\makeatletter
\def\makeSItitle{\sffamily%
    \noindent\textbf{\LARGE{Supplementary Information for}}\par\vspace{12pt}%
    \noindent\textbf{\Large\@title}\par\vspace{12pt}%
    \noindent\textbf{\normalsize\authorsSI}\par\vspace{12pt}%
    \rmfamily%
    \newcommand{\titleString}{SI: \@title}
    \runFancy}
\makeatother
    
%% Section Headers
\RequirePackage[noindentafter]{titlesec}
\titleformat*{\section}{\sffamily\sectionFontSize\bfseries}{}
\titlespacing{\section}{0pt}{18pt}{\sectiongap}
\titleformat*{\subsection}{\sffamily\normalsize\bfseries}
\titlespacing{\subsection}{0pt}{8pt}{\subsectiongap}

%% Figure
\RequirePackage{float}
\RequirePackage{graphicx}
\RequirePackage{placeins}
\setlength{\belowcaptionskip}{-10pt} 
 
%% Caption
\RequirePackage{caption}
\DeclareCaptionLabelSeparator{vline}{~\rule[-0.4ex]{0.2ex}{1.0em}~}
\DeclareCaptionLabelFormat{mylabel}{\sffamily{\textbf{#1#2}}}
\captionsetup[figure]{font={footnotesize,sf},labelfont={footnotesize},name={Fig.~},labelformat=mylabel,labelsep=vline}

%% Bibliography
\RequirePackage[style=phys,backend=biber]{biblatex}
\renewcommand*{\bibfont}{\footnotesize}
\setlength{\bibitemsep}{1pt}
\renewcommand*{\multicitedelim}{\addcomma}

%%
\RequirePackage{amsmath}
\RequirePackage{amssymb}
% \usepackage{gensymb}
% \usepackage{textcomp}
