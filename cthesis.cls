\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cthesis}[2020/05/07 CThesis class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass[twoside,a4paper]{report}

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Packages
%%%%%%%%%%%%%%%%%%%%%%%%%%

% math packages
\RequirePackage{derivative}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{mathrsfs}
\RequirePackage{siunitx}
\RequirePackage{algorithmicx}
\RequirePackage{algorithm2e}
\RequirePackage{algpseudocode}

% Graphics
\RequirePackage{graphicx}
\RequirePackage[export]{adjustbox}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{tikz}
\RequirePackage{wrapfig}

% Tables and lists
\RequirePackage{longtable}
\RequirePackage{boldline}
\RequirePackage{bigstrut}
\RequirePackage[inline]{enumitem}
\RequirePackage{multirow}
\RequirePackage{array}
\RequirePackage{slashbox}
\RequirePackage{booktabs}
\RequirePackage{tabularx}
\RequirePackage[font={sf,small}]{floatrow}

% Title sections
\RequirePackage[titles]{tocloft}
\RequirePackage[sf, bf, raggedright, explicit, pagestyles]{titlesec}
\RequirePackage{clrstrip}

% Fonts
%\RequirePackage[lining, scale=0.88]{FiraMono}
\RequirePackage{fourier}
\RequirePackage[default, bold]{sourceserifpro}
\RequirePackage{sourcesanspro}
\RequirePackage[T1]{fontenc}
\RequirePackage{moresize}
\RequirePackage{anyfontsize}

% Misc
\RequirePackage{titling}
\RequirePackage{emptypage}
\RequirePackage{xcolor}
\RequirePackage{xstring}
\RequirePackage{ragged2e}
\RequirePackage{etoolbox}
\RequirePackage[defaultlines=3,all]{nowidow}
\RequirePackage[english]{babel}
\RequirePackage{indentfirst}
\RequirePackage{xpatch}
\RequirePackage{csquotes}
\RequirePackage[multiple,bottom,norule,splitrule,marginal]{footmisc}
\RequirePackage{nameref}
\RequirePackage[toc]{appendix}
\RequirePackage[
        style=phys,
        backend=biber,
        citestyle=numeric
]{biblatex}
\RequirePackage{subfiles}

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Options
%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{kvoptions-patch}
\RequirePackage{xkeyval}

\definecolor{DocColor}{HTML}{000000}

\DeclareOptionX{accent}{\definecolor{DocColor}{HTML}{#1}}
\ExecuteOptionsX{accent=000000}
\ProcessOptionsX

\RequirePackage[
        colorlinks=true,
        linkcolor=DocColor,
        citecolor=DocColor,
        filecolor=black,
        urlcolor=DocColor,
        bookmarks=true,
        bookmarksnumbered=true,
        bookmarksopenlevel=2,
        pdfstartview=Fit,
        pdfpagelayout=SinglePage,
        plainpages=false,
        pdfpagelabels=true
]{hyperref}
\RequirePackage{bookmark}

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Formatting
%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\textfraction}{0.05}
\renewcommand{\topfraction}{0.95}
\renewcommand{\bottomfraction}{0.95}

% Fonts
%%%%%
\newcommand{\savesffamily}{\sfdefault}
\makeatletter
\newcommand{\savesfmdseries}{\mdseries@sf}
\newcommand{\savesfbfseries}{\bfseries@sf}
\makeatother

\let \savermfamily   \rmdefault
\let \savermmdseries \mddefault
\let \savermbfseries \bfdefault

% Layouts
%%%%%
\newpagestyle{main}[\small\sffamily\selectfont]{
        \sethead%
        [\textbf{\thepage}~~|~~%
        \ifthechapter{\thechapter~~}{}\chaptertitle]% even-left
        []% even-center
        []% even-right
        {}% odd-left
        {}% odd-center
        {\ifx\sectiontitle\empty%
                \ifthechapter{\thechapter~~}{}\chaptertitle%
         \else%
                \ifthesection{\thesection~~}{}\sectiontitle
         \fi
         ~~|~~\textbf{\thepage}%
        }%	odd-right
}

% Style for the front matter
\newpagestyle{front}[\small\sffamily\selectfont]{
        \sethead
        [\textbf{\thepage}]
        []
        []
        {}
        {}
        {\textbf{\thepage}}
}

\assignpagestyle{\chapter}{empty}

% Spacing etc.
\flushbottom

\newlength{\origbaselineskip}
\setlength{\origbaselineskip}{\baselineskip}

\ifdef{\linesperpagedesired}
        {}
        {\newcommand{\linesperpagedesired}{42}}

\makeatletter
\newcommand{\newbaselinestretch}{1.1}
\makeatother

\linespread{\newbaselinestretch}

\newlength{\newbaselineskip}
\setlength{\newbaselineskip}{
        \dimexpr (\textheight - \topskip) / (\linesperpagedesired - 1)
}

\setlength{\textheight}{\dimexpr \numexpr \linesperpagedesired - 1 \relax \newbaselineskip + \topskip}  % to prevent too small \textheigtht due to rounding errors
\newlength{\newparindent}
\setlength{\newparindent}{1.15\newbaselineskip}%

\setlength{\parskip}{0pt}

% TOC options
%%%%%
\renewcommand{\cftdotsep}{\cftnodots}
\renewcommand{\cftsecfont}{\sffamily\bfseries}
\makeatletter
\@ifclassloaded{article}{}{\renewcommand{\cftchapfont}{\large\sffamily\bfseries}}
\@ifclassloaded{article}{}{\renewcommand{\cftchappagefont}{\cftchapfont}}
\makeatother
\renewcommand{\cftsecpagefont}{\cftsecfont}
\renewcommand{\cftsubsecfont}{\sffamily}
\renewcommand{\cftsubsecpagefont}{\cftsubsecfont}
\renewcommand{\cftsubsubsecfont}{\small\sffamily}
\renewcommand{\cftsubsubsecpagefont}{\cftsubsubsecfont}
\setlength{\cftbeforesecskip}{\smallskipamount}
\setlength{\cftfigindent}{0pt}
\setlength{\cfttabindent}{0pt}
\setlength{\cftfignumwidth}{3.75em}
\setlength{\cfttabnumwidth}{3.75em}

\setcounter{secnumdepth}{3}

% Titles
%%%%%
\titleformat{\chapter}[block]
        {\raggedleft}
        {\raisebox{-70pt}{\fontsize{80}{80}\filleft\color{DocColor}\bfseries\thechapter}}
        {0pt}%
        {\llap{\parbox[b]{\textwidth}{\filleft\sffamily\bfseries\Huge#1}}}

\titleformat{name=\chapter,numberless}[hang]
        {\raggedright}
        {}
        {0pt}%
        {\sffamily\bfseries\Huge#1}[]

\titleformat{name=\section}[hang]
        {\raggedright\Large\sffamily\bfseries}
        {\thesection\enspace}
        {0pt}
        {#1}[]

\titleformat{name=\section,numberless}[hang]
        {\raggedright\Large\sffamily\bfseries}
        {}
        {0pt}
        {#1}[]

\titleformat{name=\subsection}[hang]
        {\raggedright\large\sffamily\bfseries}
        {\thesubsection\enspace}
        {0pt}
        {#1}[]

\titleformat{name=\subsection,numberless}[hang]
        {\raggedright\large\sffamily\bfseries}
        {}
        {0pt}
        {#1}[]

\titleformat{name=\subsubsection}[hang]
        {\raggedright\normalsize\sffamily\bfseries}
        {\thesubsubsection\enspace}
        {0pt}
        {#1}[]

\titleformat{name=\subsubsection, numberless}[hang]
        {\raggedright\normalsize\sffamily\bfseries}
        {}
        {0pt}
        {#1}[]

\titleformat{name=\paragraph, numberless}[runin]
        {}
        {}
        {0pt}
        {\textbf{#1\iftextterm{#1}{}{\unskip.}}}[]

\titleformat{name=\subparagraph, numberless}[runin]
        {}
        {}
        {0pt}
        {\textbf{#1\iftextterm{#1}{}{\unskip.}}}[]

\titlespacing{\paragraph}
        {0pt}
        {0.5\baselineskip plus 0.5\baselineskip}
        {3\wordsep}[]

\titlespacing{\subparagraph}
        {\parindent}
        {0pt}
        {3\wordsep}[]

\titlespacing{\chapter}
        {0pt}
        {2.5ex plus .5ex minus .2ex}
        {4.3ex plus .2ex}

% Tables
%%%%%
% Setup captions
\DeclareCaptionLabelSeparator{periodlargespace}{.\:\:}
\captionsetup{
        singlelinecheck=on,
        figureposition=above,
        tableposition=below,
        format=plain,
        labelsep=periodlargespace,
        margin=0pt,
        font={sf, small},
        labelfont={sf,bf,small},
        justification=justified
}

% Algorithm captions
\SetAlgoCaptionSeparator{.}
\SetAlCapFnt{\small\sffamily}
\SetAlCapNameFnt{\small\sffamily}

% booktab options
\setlength{\cmidrulewidth}{.035em}
\setlength{\lightrulewidth}{.05em}
\setlength{\heavyrulewidth}{.10em}
\setlength{\abovetopsep}{-5pt}
\addtolength{\aboverulesep}{1.5pt}
\addtolength{\belowrulesep}{1.5pt}

% tabularx options
\newcolumntype{C}{>{\centering\arraybackslash}X}
\newcolumntype{J}{>{\arraybackslash}X}
\newcolumntype{L}{>{\RaggedRight\arraybackslash}X}
\newcolumntype{R}{>{\RaggedLeft\arraybackslash}X}
\newcolumntype{T}[1]{@{}S[table-format = #1, table-space-text-pre = {***}, table-space-text-post = {***}]}

\setlength{\textfloatsep}{1.5\newbaselineskip plus 0.5\newbaselineskip minus 0.0pt}

% Lists
%%%%%
\newcommand\tabitem{
  \raisebox{1pt}{\color{DocColor}\scriptsize$\blacksquare$}
}

\setlist{listparindent=\parindent, itemsep=\medskipamount, parsep=0pt}


% Footnotes
%%%%%
\setlength{\footnotemargin}{0.85\newparindent}
\renewcommand{\footnotelayout}{\hspace{0.15\newparindent}}
\renewcommand{\hangfootparindent}{\newparindent}
\preto{\footnote}{\setlength{\parindent}{\newparindent}}
\let\oldfootnoterule\footnoterule
\addtolength{\skip\footins}{\bigskipamount}

\newlength{\textparindent}
\setlength{\textparindent}{\parindent}
\newlength{\templength}
\makeatletter
\let\@makefntextorig\@makefntext
\newcommand{\@makefntextcustom}[1]{%
        \parindent 2\textparindent%
        \hspace{-\textparindent}%
        \settowidth{\templength}{0}%
        \ifnum\value{footnote}<10 \hspace{\templength}\else\fi%
        \thefootnote.\enskip #1%
}
\renewcommand{\@makefntext}[1]{\@makefntextcustom{#1}}
\makeatother

% Beginning of the Document
%%%%%
\AtBeginDocument{
        \captionsetup{footfont={sf,footnotesize}}

        \setlength{\baselineskip}{\newbaselineskip}
        \setlength{\parindent}{\newparindent}
        \setlength{\lineskiplimit}{0pt}

        \let\nonfrenchspacing=\frenchspacing
        \frenchspacing
        \sloppy

        \renewcommand{\splitfootnoterule}{{\hfrule width 0.5\textwidth}}
        \renewcommand{\footnoterule}{\oldfootnoterule\medskip}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Commands
%%%%%%%%%%%%%%%%%%%%%%%%%%
\makeatletter
\renewenvironment{cases}[1][\lbrace]{%
  \def\@ldelim{#1}
  \matrix@check\cases\env@cases
}{%
  \endarray\right.%
}
\patchcmd{\env@cases}{\lbrace}{\@ldelim}{}{}
\makeatother

\makeatletter
\newcommand*{\currentname}{\@currentlabelname}
\makeatother

\renewcommand{\floatfootskip}{\smallskipamount}
\newcommand{\tablenotes}[2][Notes:]{
        \floatfoot{
                \setlength{\baselineskip}{11pt}
                \textit{#1} #2
        }
}

\newcommand{\figurenotes}[2][Notes:]{
        \floatfoot{
                \setlength{\baselineskip}{11pt}
                \vspace{-\floatfootskip}
                \vspace{\medskipamount}
                \\[-\baselineskip]
                \textit{#1} #2
        }
}

% Abstract
%%%%%
\renewenvironment{abstract}{
        \section*{\abstractname}
}


% Title page
%%%%%
\makeatletter
\newcommand{\thesistype}[1]{\gdef\@thesistype{#1}}
\newcommand{\@thesistype}{\@latex@warning@no@line{No \noexpand\thesistype given}}

\newcommand{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand{\@supervisor}{\@latex@warning@no@line{No \noexpand\supervisor given}}

\newcommand{\titlecolor}[1]{\gdef\@titlecolor{#1}}
\newcommand{\@titlecolor}{\@latex@warning@no@line{No \noexpand\titlecolor given}}

\newcommand{\txtcolor}[1]{\gdef\@txtcolor{#1}}
\newcommand{\@txtcolor}{\@latex@warning@no@line{No \noexpand\txtcolor given}}

\newcommand{\gap}[1]{\gdef\@gap{#1}}
\newcommand{\@gap}{\@latex@warning@no@line{No \noexpand\gap given}}
\makeatother

\makeatletter
\renewcommand\maketitle{{

\vspace*{\@gap}%
\begin{colorstrip}{\@titlecolor}
[%
inner bot=1.2cm, outer bot=\bigskipamount, width=\textwidth,
inner top=1cm, left=-1cm
]
\color{\@txtcolor}
\raggedright
\LARGE \@thesistype\\
\vspace*{0.5cm}
\LARGE\textbf{\@title}\\
\rmfamily
\vspace*{1cm}
\normalsize\textit{by}\\
\large\@author\\
\vspace{0.75cm}
\normalsize\textit{supervised by}\\
\large\@supervisor\\
\vspace{0.75cm}
\@date
\noindent
\hfill
\end{colorstrip}
}}
\makeatother