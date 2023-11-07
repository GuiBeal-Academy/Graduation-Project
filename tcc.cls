%==============================================================================
% tcc - Documents for TCC 
% Copyright (C) 2018..2020 Alceu Frigeri
%
% This class was adapted from:
% deletex - Documents for DELET/EE/UFRGS
% Copyright (C) 2004..2009 Walter Fetter Lages <w.fetter@ieee.org>
%
% $Id: iiufrgs.cls,v 4.14 2003/11/21 22:36:13 avila Exp $
% Copyright (C) 2001-2003 UFRGS TeX Users Group
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%
%==============================================================================

%==============================================================================
% Identificação
%==============================================================================
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tcc}[2020/01/20 v2.1.0 TCC class]

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
% Para reconhecer o conjunto de
% caracteres latin1 (á) na entrada (.tex) e evitar a necessidade
% de utilizar o formato tradicional: (\'a)

%==============================================================================
% Declaração de opções
%==============================================================================
\DeclareOption{english}{\@englishtrue\OptionNotUsed}\newif\if@english
\DeclareOption{relnum}{\@relnumtrue\OptionNotUsed}\newif\if@relnum
\DeclareOption{oneside}{\AtEndOfClass{\@twosidefalse}\OptionNotUsed}
\newif\if@repeatfields\@repeatfieldsfalse
\DeclareOption{repeatfields}{\@repeatfieldstrue}
\DeclareOption{@coord}{\gdef\@coord{}}
\DeclareOption{distinctboard}{\gdef\@nBoard{}}
\DeclareOption{report}{\gdef\@report{}}
\DeclareOption{internship}{\gdef\@internship{}}
\def\TCCserif{\sffamily}
\DeclareOption{serif}{\def\TCCserif{\relax}}
\DeclareOption{sansserif}{\def\TCCserif{\sffamily}}
\newif\if@lmodern\@lmodernfalse
\DeclareOption{modern}{\@lmoderntrue}
\DeclareOption{times}{\@lmodernfalse}
\DeclareOption{abntpage}{\gdef\@abntpage{}}
\DeclareOption{showframe}{\gdef\@showframe{}}
\DeclareOption{showlabels}{\gdef\@showlabels{}}
\DeclareOption{MiKTeX}{
  \def\set@curr@file#1{%
    \begingroup
      \escapechar\m@ne
      \xdef\@curr@file{\expandafter\string\csname #1\endcsname}%
    \endgroup
  }
  \def\quote@name#1{"\quote@@name#1\@gobble""}
  \def\quote@@name#1"{#1\quote@@name}
  \def\unquote@name#1{\quote@@name#1\@gobble"}
}
\newif\if@overleaf\@overleaffalse
\DeclareOption{overleaf}{\@overleaftrue\PackageWarning{TCC CCA}{OVERLEAF option used ! Workarounds enabled !}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
%==============================================================================
% Herança da classe `report' e inclusão de pacotes e arquivos necessários
%==============================================================================
\LoadClass[12pt,a4paper,twoside]{report}
%%%\renewcommand{\baselinestretch}{1.5} %% this is the correct spacing after NBR-14724
\RequirePackage[english,brazilian]{babel}

\if@lmodern
  \RequirePackage{lmodern}
\else
  \RequirePackage{mathptmx}
\fi

\RequirePackage{csquotes}
\RequirePackage{silence}
\WarningFilter{biblatex}{File 'brazilian-abnt-abnt.lbx'}
\WarningFilter{biblatex}{Conflicting options}
\if@repeatfields
	\RequirePackage[backend=biber,style=abnt,pretty,giveninits,extrayear,repeatfields]{biblatex}
\else
	\RequirePackage[backend=biber,style=abnt,pretty,giveninits,extrayear]{biblatex}
\fi
%
\if@english
        \selectlanguage{english}
        \AtBeginDocument{\selectlanguage{english}}
\fi
\RequirePackage{lastpage}

%\RequirePackage{float}% Para posicionar as figuras de forma mais conveniente
\RequirePackage{url}% Para imprimir corretamente URLs
\RequirePackage{enumerate}% Para poder enumerar com letras ao inves de numeros

\RequirePackage{keyval,graphicx}  % Para importar figuras
\RequirePackage{amsmath}
\RequirePackage{mathrsfs, amsfonts, amssymb}
\RequirePackage{amsthm, mathtools}
\RequirePackage{empheq}
\RequirePackage{cases}
\RequirePackage{extarrows}
\RequirePackage{mathfixs}

\RequirePackage[nomessages]{fp}
\RequirePackage{multirow,bigdelim}

\RequirePackage{listings}
\RequirePackage{xcolor}
\RequirePackage{newfloat}

\if@overleaf
  \PackageWarning{TCC CCA}{OVERLEAF workaround for CircuitTikZ PGF/TiKZ  enabled}
	\RequirePackage[american,siunitx,cuteinductors,smartlabels,arrowmos,betterproportions]{circuitikz}
\else
	\RequirePackage[american,siunitx,cuteinductors,smartlabels,arrowmos,EFvoltages,betterproportions]{circuitikz}
\fi
	\usetikzlibrary{fit}
	\usetikzlibrary{math}
	\usetikzlibrary{calc}
	\usetikzlibrary{shapes.geometric} %needed for the triangle
	\usetikzlibrary{shapes.misc} %needed for the triangle
	\usetikzlibrary{graphs}
	\usetikzlibrary{3d}
	
%\usepgflibrary{arrows.meta}

\RequirePackage{steinmetz}

\RequirePackage[position=above,font=small,labelfont=bf,textfont=md,textfont+=sl,width=\textwidth]{caption}
%%\RequirePackage{subcaption} %% OVERLEAF !!!

\RequirePackage{microtype}

\def\notename{Note}
\newlength{\noteindent}
\newcommand{\note}[2][]{{\footnotesize\settowidth{\noteindent}{\notename#1:}\addtolength{\noteindent}{3pt}\begin{center}\begin{minipage}{0.73\textwidth}{\parindent=-\the\noteindent\notename#1:\hspace{2.9pt}#2}\end{minipage}\end{center}}}

\@ifundefined{@showframe}{}{\RequirePackage{showframe}}

\@ifundefined{@showlabels}{}{
	\RequirePackage{showlabels}
	\showlabels{cite}
	\showlabels{textcite}
	\renewcommand{\showlabelfont}{\tiny\ttfamily\color{blue}}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%==============================================================================
% Margens do texto
%==============================================================================
\newlength{\TCC@topmargin}\setlength{\TCC@topmargin}{30mm}
\newlength{\TCC@pagenummargin}\setlength{\TCC@pagenummargin}{20mm}
\newlength{\TCC@bottommargin}\setlength{\TCC@bottommargin}{20mm}
\newlength{\TCC@sidemargin}\setlength{\TCC@sidemargin}{30mm}
\newlength{\TCC@leftsidemargin}\setlength{\TCC@leftsidemargin}{30mm}
\newlength{\TCC@rightsidemargin}\setlength{\TCC@rightsidemargin}{22.5mm}

% ajuste das medidas verticais
\setlength{\topmargin}{\TCC@pagenummargin}
        \addtolength{\topmargin}{-1em} % isto é +- a altura do núm. da página
        \addtolength{\topmargin}{-1in}
\setlength{\headheight}{1em}
\setlength{\headsep}{\TCC@topmargin}
        \addtolength{\headsep}{-\TCC@pagenummargin}
\setlength{\textheight}{\paperheight}
        \addtolength{\textheight}{-\TCC@topmargin}
        \addtolength{\textheight}{-\TCC@bottommargin}
\setlength{\footskip}{\TCC@bottommargin}


\@ifundefined{@abntpage}{
\setlength{\marginparwidth}{25mm}
  % ajuste das medidas horizontais
  \setlength{\oddsidemargin}{\TCC@sidemargin}
        \addtolength{\oddsidemargin}{-1in}

  \setlength{\evensidemargin}{\oddsidemargin}

  \setlength{\textwidth}{\paperwidth}
          \addtolength{\textwidth}{-2\TCC@sidemargin}

  \setlength{\marginparsep}{\TCC@sidemargin}
        \addtolength{\marginparsep}{-\marginparwidth}
        \setlength{\marginparsep}{.5\marginparsep}
}{
  \setlength{\marginparwidth}{18mm}
  % ajuste das medidas horizontais
  \setlength{\hoffset}{0pt}
  \setlength{\paperwidth}{209mm} %%% valor ERRADO, mas correspondente as folhas de papel na secretaria !!!
  \setlength{\oddsidemargin}{\TCC@sidemargin}
          \addtolength{\oddsidemargin}{-1in}

  %\setlength{\evensidemargin}{\oddsidemargin}
  \setlength{\evensidemargin}{\TCC@rightsidemargin}
          \addtolength{\evensidemargin}{-1in}

  \setlength{\textwidth}{\paperwidth}
  %        \addtolength{\textwidth}{-2\TCC@sidemargin}
          \addtolength{\textwidth}{-\TCC@sidemargin}
          \addtolength{\textwidth}{-\TCC@rightsidemargin}


  %\setlength{\marginparsep}{\TCC@sidemargin}
  \setlength{\marginparsep}{\TCC@rightsidemargin}
          \addtolength{\marginparsep}{-\marginparwidth}
          \setlength{\marginparsep}{.5\marginparsep}
}

%==============================================================================
% Numeração das páginas
%==============================================================================
\def\ps@TCC{
        \let\@oddfoot\@empty%
        \let\@evenfoot\@empty%
        \def\@evenhead{{\small\thepage}}%
        \def\@oddhead{\hspace*{\fill}{\small\thepage}}%
}%
\pagestyle{empty}
\let\ps@plain\ps@empty

% Nao numera versos de paginas em branco
\def\cleardoublepage{%
        \clearpage%
        \if@twoside%
		\ifodd\c@page%
% do nothing%
		\else%
			\hbox{}%
			\thispagestyle{empty}%
			\newpage%
		\fi%
	\fi%
}%
%
%
%
%==============================================================================
% Definição da capa, folha de rosto e folha de aprovação.
% Os dados específicos do tipo de trabalho (dissertação, tese, etc.) são
% informados definindo-se o comando \titlepagespecificinfo. Veja os
% arquivos .def incluídos com a classe.
%==============================================================================
\newlength{\titlepagewinwidth}\setlength{\titlepagewinwidth}{95mm}%
\newlength{\titlepagewinheight}\setlength{\titlepagewinheight}{64mm}%
\newlength{\titlepagewinvoffset}\setlength{\titlepagewinvoffset}{112mm}%
\newcommand{\location}[2]{%
        \gdef\@city{#1}%
        \gdef\@state{#2}%
}%
%
%
%
%==============================================================================
% Definição das palavras-chave (máx. 10)
%==============================================================================
\newcounter{kwcounter}%
\newcommand{\keyword}[1]{%%
        \stepcounter{kwcounter}%%
        \expandafter\gdef\csname keyw\alph{kwcounter}\endcsname{#1}%%
}%
\newcommand{\@cipkw}{%
        \@ifundefined{keywa}{}{1.~\expandafter\MakeUppercase\keywa\@. }%
        \@ifundefined{keywb}{}{2.~\expandafter\MakeUppercase\keywb\@. }%
        \@ifundefined{keywc}{}{3.~\expandafter\MakeUppercase\keywc\@. }%
        \@ifundefined{keywd}{}{4.~\expandafter\MakeUppercase\keywd\@. }%
        \@ifundefined{keywe}{}{5.~\expandafter\MakeUppercase\keywe\@. }%
        \@ifundefined{keywf}{}{6.~\expandafter\MakeUppercase\keywf\@. }%
        \@ifundefined{keywg}{}{7.~\expandafter\MakeUppercase\keywg\@. }%
        \@ifundefined{keywh}{}{8.~\expandafter\MakeUppercase\keywh\@. }%
        \@ifundefined{keywi}{}{9.~\expandafter\MakeUppercase\keywi\@. }%
        \@ifundefined{keywj}{}{10.~\expandafter\MakeUppercase\keywj\@. }%
}%
\newcommand{\@abstractkw}{%%
        \@ifundefined{keywa}{}{\expandafter\MakeUppercase\keywa}%%
        \@ifundefined{keywb}{}{, \keywb}%%
        \@ifundefined{keywc}{}{, \keywc}%%
        \@ifundefined{keywd}{}{, \keywd}%
        \@ifundefined{keywe}{}{, \keywe}%
        \@ifundefined{keywf}{}{, \keywf}%
        \@ifundefined{keywg}{}{, \keywg}%
        \@ifundefined{keywh}{}{, \keywh}%
        \@ifundefined{keywi}{}{, \keywi}%
        \@ifundefined{keywj}{}{, \keywj}%
}%
%
%==============================================================================%
% Redefinição da data (para ter mês e ano separados)%
%==============================================================================%
\renewcommand{\date}[3][\number\day]{%
        \gdef\@publmonth{#2}%
        \gdef\@publyear{#3}%
				\gdef\@publday{\ifnum #1<10 0\fi #1}%
}%
\date{\monthname}{\number\year}%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% \@cdef => \gdef\@#1{}%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@cdef}[2]{%
  \expandafter\gdef\csname @#1\endcsname{#2}%
}%
%
%
%==============================================================================%
% Definição do Departamento relacionado ao documento%
%==============================================================================%
\newcommand{\factory}[1]{\expandafter\def\csname #1\endcsname##1{\@cdef{#1}{##1}}}%
\newcommand{\cmdfactory}[1]{\forcsvlist{\factory}{#1}}%
%
\cmdfactory{department,course,courseacronym,graduationtitle,coursecoordtitle,coursecoord,subject,advisorwidth,cipspecificinfo,cipunit,tcc, }%
%
\advisorwidth{0.57\textwidth}%
%
\newcommand{\courseundef}{\let\@course\undefined}%
%%%\newcommand{\csundef}[1]{\expandafter\let\csname @#1\endcsname\undefined}
%
\newcommand{\class}[2]{\@cdef{classcode}{#1}\@cdef{classname}{#2}}%
%
%
\newcommand{\@checklist}[1]{\expandafter\gdef\csname @student\Alph{TCC@studentcount}:#1\endcsname{}}%
\newcommand{\checklist}[1]{\forcsvlist{\@checklist}{#1}}%
%
\newcommand{\checkedbox}{\ooalign{$\square$\cr\hidewidth\raise.3ex\hbox{$\checkmark\mkern-7mu$}\hidewidth\cr}}%
\newcommand{\uncheckedbox}{$\square$}%
\newcommand{\@@check}[2]{\@ifundefined{@student#1:#2}{\uncheckedbox}{\checkedbox}}%
\newcommand{\@check}[2]{\@ifundefined{#2}{}{\@@check{#1}{\csname #2\endcsname} \csname @\csname #2\endcsname\endcsname}}%
\newcommand{\@checkdef}[3]{\expandafter\gdef\csname #1\endcsname{#2}\expandafter\gdef\csname @#2\endcsname{#3}}%
%\chekmark%
%
%
%==============================================================================%
% Ajuste do sumário (nada indentado) %
%==============================================================================%
\newlength{\TCC@chapnumindent}\setlength{\TCC@chapnumindent}{1.8em}%
\renewcommand*{\l@chapter}[2]{%
        \addpenalty{-\@highpenalty}%
        \vskip -1ex \@plus\p@%
        \setlength\@tempdima{1.5em}%
        \begingroup%
        \parindent \z@ \rightskip \@pnumwidth%
        \parfillskip -\@pnumwidth%
        \leavevmode\bfseries\TCCserif%
        \advance\leftskip\@tempdima%
        \hskip -\leftskip%
%      esta é a definicao original da classe report:%
%      #1\nobreak\hfil \nobreak\hb@xt@\@pnumwidth{\hss #2}\par%
        \@dottedtocline{0}{0em}{\TCC@chapnumindent}{\uppercase{#1}}{#2}%
%        \@dottedtocline{0}{0em}{\TCC@chapnumindent}{\MakeUppercase{#1}}{#2}%
        \penalty\@highpenalty%
        \endgroup%
}%
\renewcommand*{\l@section}[2]%
              {\@dottedtocline{1}{0em}{2.8em}{\textbf{#1}}{\hss #2}}%
\renewcommand*{\l@subsection}{\@dottedtocline{2}{0em}{3.7em}}%
\renewcommand*{\l@subsubsection}{\@dottedtocline{3}{0em}{4.3em}}%
\newif\if@aftertoc%
\@aftertocfalse%
\renewcommand{\tableofcontents}{%%
        \chapter*{\contentsname}%
        \@starttoc{toc}\@aftertoctrue%%
}%
%
%==============================================================================%
% Definição das listas de abreviaturas e siglas e de símbolos%
%==============================================================================%
\newenvironment{listofabbrv}[1]{%
        \chapter*{\listabbrvname}%
        \begin{list}{\textbf{??}}{%
                \settowidth{\labelwidth}{#1}%
                \setlength{\labelsep}{1em}%
                \setlength{\itemindent}{0mm}%
                \setlength{\leftmargin}{\labelwidth}%
                \addtolength{\leftmargin}{\labelsep}%
                \setlength{\rightmargin}{0mm}%
                \setlength{\itemsep}{.1\baselineskip}%
                \renewcommand{\makelabel}[1]{\makebox[\labelwidth][l]{##1}}%
        }%
}{%
        \end{list}%
}%
\newenvironment{listofsymbols}[1]{%
        \chapter*{\listsymbolname}%
        \begin{list}{\textbf{??}}{%
                \settowidth{\labelwidth}{#1}%
                \setlength{\labelsep}{1em}%
                \setlength{\itemindent}{0mm}%
                \setlength{\leftmargin}{\labelwidth}%
                \addtolength{\leftmargin}{\labelsep}%
                \setlength{\rightmargin}{0mm}%
                \setlength{\itemsep}{.1\baselineskip}%
                \renewcommand{\makelabel}[1]{\makebox[\labelwidth][l]{##1}}%
        }%
}{%
        \end{list}%
}%
%
%==============================================================================%
% Resumo (abstract) e Abstract (englishabstract)%
%==============================================================================%
\renewenvironment{abstract}{%%
        \chapter*{\abstractname}%
}{%%
        \par\vspace{2ex} %\vfill%
        \noindent\textbf{\keywordsname: \@abstractkw.}%
}%
\newenvironment{englishabstract}[1]{%%
        \if@openright\cleardoublepage\else\clearpage\fi%%
        \gdef\@englishkeywords{#1}%%
        \iflanguage{english}{%
                \begin{otherlanguage}{brazilian}%
        }{%
                \begin{otherlanguage}{english}%
        }%
                \chapter*{\abstractname}%
}{%
        \par\vspace{2ex} %\vfill%
        \noindent\textbf{\keywordsname: \@englishkeywords.}%
        \end{otherlanguage}%
}%
%
%==============================================================================%
% Formatação dos capítulos.%
% Os comandos \@chapter e \@schapter são redefinidos para que a%
% numeração de páginas seja correta (deve aparecer somente a partir do%
% primeiro capítulo do texto, mas não nas páginas iniciais de%
% capítulos).%
% Os comandos \@makechapterhead e \@makeschapterhead fazem a%
% formatação dos títulos propriamente ditos.%
%==============================================================================%
\newcommand{\TCC@chapterfont}{\@setfontsize\Large{16}{20}}%
\def\@chapapp{}%
\def\@chapter[#1]#2{%%
        \refstepcounter{chapter}%%
        \addcontentsline{toc}{chapter}{\protect\numberline{\@chapapp\thechapter~\@chapext}#1}%%
\if@relnum%
        \addtocontents{lof}{\protect\addvspace{10\p@}}%%
        \addtocontents{lot}{\protect\addvspace{10\p@}}%%
\fi%
        \pagestyle{TCC}\let\ps@plain\ps@TCC%%
        \@makechapterhead{#2}\@afterheading%
}%
\def\@chapext{}%
\def\@makechapterhead#1{%%
        \vspace*{90pt}%
        \reset@font\noindent{\TCC@chapterfont\TCCserif\textbf{\@chapapp\thechapter~\@chapext\MakeUppercase{#1}}\par}%
        \addvspace{42pt}%
}%
\def\@schapter#1{%%
        \if@aftertoc\addcontentsline{toc}{chapter}{#1}\fi%%
\if@relnum%
        \addtocontents{lof}{\protect\addvspace{10\p@}}%%
        \addtocontents{lot}{\protect\addvspace{10\p@}}%%
\fi%
        \@makeschapterhead{#1}\@afterheading%
}%
\def\@makeschapterhead#1{%%
        \vspace*{90pt}%
        \reset@font\centerline{\TCC@chapterfont\TCCserif\textbf{\MakeUppercase{#1}}}%
        \addvspace{42pt}%
}%

\newlength{\@toctemp}
	
\renewcommand{\appendix}[1][\appendixname]{%%
        \setcounter{chapter}{0}%%
        \renewcommand{\thechapter}{\Alph{chapter}}%%
        \setcounter{tocdepth}{0}%%
        \@captionlistingfalse%%
        \gdef\@chapapp{\MakeUppercase{#1}~}%%
				\gdef\@chapext{-~}
				\settowidth{\@toctemp}{\TCCserif\textbf{\@chapapp}}%
        \addtolength{\@toctemp}{1.8em}%
        \addtocontents{toc}{%%
					\setlength{\TCC@chapnumindent}{\the\@toctemp}
        }%%
}%
	\newcommand{\annex}{\appendix[\annexname]}%
%
%==============================================================================%
% Formatação das seções%
%==============================================================================%
\setcounter{secnumdepth}{4}%
\renewcommand{\section}{%%
        \@startsection{section}{1}{0pt}{18pt}{9pt}{\reset@font\large\bfseries}%
}%
\renewcommand{\subsection}{%%
        \@startsection{subsection}{2}{0pt}{12pt}{6pt}{\reset@font\bfseries}%
}%
\renewcommand{\subsubsection}{%%
        \@startsection{subsubsection}{3}{0pt}{12pt}{6pt}{\reset@font\itshape}%
}%
\renewcommand{\paragraph}{%%
        \@startsection{paragraph}{4}{0pt}{12pt}{6pt}{\reset@font}%
}%
\renewcommand{\subparagraph}{%%
        \@startsection{subparagraph}{5}{0pt}{1ex}{-1em}{\reset@font\bfseries}%
}%
%
%
%
%
%
%%%%\def\listoflistings{\lstlistoflistings}%
\definecolor{lstgray}{rgb}{0.965,0.965,0.965}%
\lstset{basicstyle=\ttfamily\small,%
  columns=fullflexible,%
  keepspaces=true,%
  frame=tb,%
  inputencoding=latin1,%
%  inputencoding=utf8,%
  extendedchars=true,%
  backgroundcolor=\color{lstgray},%
	breaklines=true,%
%	xleftmargin=7pt,%
%	xrightmargin=7pt%
}%
%
\if@relnum%
\lstset{numberbychapter=true}%
\else%
\lstset{numberbychapter=false}%
\fi %
%
%
%
\newcommand{\DeclareNewFloat}[4]{%
 \DeclareFloatingEnvironment[%
  fileext=#2,%
	listname={#4},%
	name=#3,%
	placement=htb,%
	chapterlistsgaps=off]{#1} %
 \if@relnum%
  \SetupFloatingEnvironment{#1}{within=chapter}%
 \else%
  \SetupFloatingEnvironment{#1}{within=none}%
 \fi %
}%
%
\def\listingname{Listing}%
\def\listlistingname{List of Listings}%

\if@overleaf
	\PackageWarning{TCC CCA}{OVERLEAF workaround for newfloat enabled (package disabled)}
	\newenvironment{listing}[1][htb]{\begin{figure}[#1]}{\end{figure}}
	\newcommand{\listoflistings}{\PackageWarning{TCC CCA}{OVERLEAF workaround for newfloat enabled (package disabled)}
}
\else
	\DeclareNewFloat{listing}{lox}{\listingname}{\listlistingname}%
\fi

%
%==============================================================================%
% Redefinição do conteúdo das listas de figuras e tabelas%
%==============================================================================%
\newif\if@captionlisting\@captionlistingtrue%
\long\def\@caption#1[#2]#3{%%
  \par%
  \if@captionlisting%%
    \addcontentsline{\csname ext@#1\endcsname}{#1}%%
        {\protect\numberline{\csname fnum@#1\endcsname:}{\ignorespaces #2}}%%
  \fi%%
  \begingroup%
    \@parboxrestore%
    \if@minipage%
      \@setminipage%
    \fi%
    \normalsize%
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces #3}\par%
  \endgroup%%
}%
\renewcommand*{\l@figure}{\@dottedtocline{1}{0em}{2em}}%
%
\let\l@table\l@figure%
%
\let\l@listing\l@figure%
%
%
%longtable support%
\RequirePackage{longtable}%
\def\LT@c@ption#1[#2]#3{%%
  \LT@makecaption#1\fnum@table{#3}%%
  \def\@tempa{#2}%%
  \ifx\@tempa\@empty\else%
     {\let\\\space%
     \addcontentsline{lot}{table}{\protect\numberline{\tablename~\thetable:}{#2}}}%%
  \fi}%
%
%==============================================================================%
% Redefinição do formato de citações longas%
%==============================================================================%
\renewenvironment{quote}{%%
        \small%%
        \begin{list}{}{\setlength{\leftmargin}{40mm}\item\relax}%%
}{%%
        \end{list}%%
}%
%
%==============================================================================%
% Ajuste do formato das citações e referências%
%==============================================================================%
%\setlength{\bibhang}{0pt}%
%\let\cite\citep%
%
% Segundo a NBR-6023 as referencias devem ser alinhadas somente a esquerda%
%\let\oldbibliography\bibliography%
%\renewcommand{\bibliography}[1]{\begin{flushleft}\oldbibliography{#1}\end{flushleft}}%
%
%==============================================================================%
% Ajuste do formato das numeracoes das figuras, tabelas e equações%
%==============================================================================%
\if@relnum%
%%
\else%
  \@removefromreset{equation}{chapter}%
  \renewcommand{\theequation}{\@arabic\c@equation}%
%%
  \@removefromreset{figure}{chapter}%
  \renewcommand{\thefigure}{\@arabic\c@figure}%
%%
  \@removefromreset{table}{chapter}%
  \renewcommand{\thetable}{\@arabic\c@table}%
\fi%
%
%
%
%for english%
\@namedef{captionsenglish}{%%
 \input{TCC-en-base.def}%%
}%
\@namedef{dateenglish}{%%
	\def\today{\monthname\space\number\day,\space\number\year}%%
	\def\monthname{%%
		\ifcase\month\or%%
			January\or February\or March\or April\or%%
			May\or June\or July\or AugustIII\or September\or%%
			October\or November\or December%%
		\fi%%
	}%%
	\def\TCC@date{\@publmonth~\@publyear}%%
}%
%
%para portugues%
\@namedef{captionsbrazilian}{%%
 \input{TCC-pt_BR-base.def}%%
}%
\@namedef{datebrazilian}{%%
	\def\today{\number\day\space de\space\monthname\space de\space\number\year}%%
	\def\monthname{%%
		\ifcase\month\or%%
			janeiro\or fevereiro\or mar{\c{c}}o\or abril\or%%
			maio\or junho\or julho\or agosto\or setembro\or%%
			outubro\or novembro\or dezembro%%
		\fi%%
	}%%
	\def\TCC@date{\@publmonth\ de~\@publyear}%%
}%
%
%%%%%%%%%%%%%%%%%%
%
%
%
%
%
%
%
%
%==============================================================================%
% Definição de autor(es), orientador, co-orientador e banca%
%==============================================================================%
\newcommand{\@articledefx}[5]{%
  \expandafter\gdef\csname #1article\endcsname{#2}%
  \expandafter\gdef\csname #1narticle\endcsname{#3}%
  \expandafter\gdef\csname #1Article\endcsname{#4}%
  \expandafter\gdef\csname #1Narticle\endcsname{#5}%
}%
\newcommand{\@articledefn}[1]{%
	\@articledefx{#1}{o(a)}{(a)}{O(A)}{(A)}%
}%
\newcommand{\@articledefm}[1]{%
	\@articledefx{#1}{o}{}{O}{}%
}%
\newcommand{\@articledeff}[1]{%
	\@articledefx{#1}{a}{a}{A}{A}%
}%
\newcommand{\@articledef}[2]{%
	\ifthenelse{\equal{#2}{m}}{%%
		\@articledefm{#1}%%
	}{%%
 		\ifthenelse{\equal{#2}{f}}{%%
	 	  \@articledeff{#1}%%
		}{%%
		  \@articledefn{#1}%%
		}%%
	}%%
}%
\newcommand{\TCCcoordgender}[1][m]{%%
	\@articledef{@TCCcoord}{#1}%%
}%
\newcommand{\coursecoordgender}[1][m]{%%
	\@articledef{@coursecoord}{#1}%%
}%%
%
%
\newcommand{\@@advisorref}[1]{\csname @student\Alph{TCC@studentcount}@advisor#1\endcsname}%
\newcommand{\@@coadvisorref}[1]{\csname @student\Alph{TCC@studentcount}@coadvisor#1\endcsname}%
\newcommand{\@@examinerref}[1]{\csname \@@examiners#1\endcsname}%
\newcommand{\@examiners}[1]{\def\@@examiners{@student\Alph{TCC@studentcount}@#1}}%
\newcommand{\@@studentref}[1]{\csname @student\Alph{TCC@studentcount}#1\endcsname}%
\newcommand{\@@coursecoordref}[1]{\csname @coursecoord#1\endcsname}%
\newcommand{\@@TCCcoordref}[1]{\csname @TCCcoord#1\endcsname}%
%
%
\newcounter{TCC@studentcount}%
\renewcommand{\author}[2]{%
        \stepcounter{TCC@studentcount}%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}last\endcsname{#1}%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}first\endcsname{#2}%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}\endcsname{#2 #1}%
				\@articledefn{@student\Alph{TCC@studentcount}}%
}%
%
\newcommand{\authorinfo}[3][]{%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}Nproc\endcsname{#1}%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}ID\endcsname{#2}%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}email\endcsname{#3}%
}%
\newcommand{\authorgender}[1][m]{%%
	\@articledef{@student\Alph{TCC@studentcount}}{#1}%%
}%
\newcommand{\student}[2]{\author{#1}{#2}}%
\newcommand{\studentinfo}[3][]{\authorinfo[#1]{#2}{#3}}%
\newcommand{\studentgender}[1][m]{\authorgender[#1]}%
\newcommand{\studentExam}[1]{%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}Exam\endcsname{#1}%
}%
\newcommand{\studentFF}{%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}FF\endcsname{1}%
				\gdef\@TCCff@flag{1}%
}%
\newcommand{\studentDismiss}{%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}Dismiss\endcsname{1}%
				\gdef\@TCCdismiss@flag{1}%
}%
\newcommand{\studentFate}[1][]{%%
	\ifthenelse{\equal{#1}{C}}{%%
		\studentExam{C}%%
	}{%%
		\ifthenelse{\equal{#1}{D}}{%%
			\studentExam{D}%%
		}{%%
			\ifthenelse{\equal{#1}{FF}}{%%
				\studentFF%%
			}{%%
				\ifthenelse{\equal{#1}{Dismiss}}{%%
					\studentDismiss%%
				}{%%
				}%%
			}%%
		}%%
	}%%
}%%
%
\newcommand{\studentBoardsnewpage}{%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}BoardsNP\endcsname{1}%
}%
%
\newcommand{\studenttimeslot}[3][]{%%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}date\endcsname{#2}%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}time\endcsname{#3}%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}local\endcsname{#1}%
}%
\let\timeslot\studenttimeslot%
%
\newcommand{\tccdate}[2]{%%
  \expandafter\gdef\csname date:#1\endcsname{#2}%
}%
%
\newcommand{\studentTCCtitle}[1]{%%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}title\endcsname{#1}%
}%
\let\TCCtitle\studentTCCtitle%
%
\newcommand{\studentremark}[1]{%%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}remark\endcsname{#1}%
}%
%
\DeclareRobustCommand{\@ProfFields}[4]{%%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}@#1last\endcsname{#3}%%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}@#1first\endcsname{#4}%%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}@#1\endcsname{#2~#4 #3}%%
				\@articledefn{@student\Alph{TCC@studentcount}@#1}%
}%
\DeclareRobustCommand{\@ProfInfo}[5]{%%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}@#1institution\endcsname{#2}%%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}@#1titleinfo\endcsname{#3}%%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}@#1email\endcsname{#4}%%
        \expandafter\gdef\csname @student\Alph{TCC@studentcount}@#1phone\endcsname{#5}%%
}%
\newcommand{\@ProfGender}[2]{%%
	\@articledef{@student\Alph{TCC@studentcount}@#1}{#2}%%
}%
%
%
\newcommand{\new@student}[2]{%%
	\expandafter\newcommand\csname #1\endcsname[1][]{%%
		#2%
		\@ifundefined{studentBoards##1}{}{\csname studentBoards##1\endcsname}%%
		\if@coord@forms@revforms
			\examinersforms
		\fi
%		\@ifundefined{@coord@revforms}{}{\examinersforms}%
		\if@coord@forms@referral
			\@TCCreferralletter
		\fi
%			\@ifundefined{@coord@referral}{}{\@TCCreferralletter}%
		\@defaultboard%
	}%%
}%
%
\newcommand{\@distinctboard}{\def\@nBoard{}}%
\newcommand{\@defaultboard}{\let\@nBoard\undefined}%
%
\newcounter{TCC@examinercount}[TCC@studentcount]%
%
\newcommand{\advisor}[3][]{%%
	\@ProfFields{advisor}{#1}{#2}{#3}%%
%%% the advisor is also the first examiner if not @nBoard%
	\@ifundefined{@nBoard}{\examiner[#1]{#2}{#3}}{}%%
}%
\newcommand{\advisorinfo}[4]{%%
	\@ProfInfo{advisor}{#1}{#2}{#3}{#4}%%
%%% the advisor is also the first examiner if not @nBoard%
	\@ifundefined{@nBoard}{\examinerinfo{#1}{#2}{#3}{#4}}{}%%
}%
\newcommand{\advisorgender}[1][m]{%%
	\@ProfGender{advisor}{#1}%
%%% the advisor is also the first examiner if not @nBoard%
	\@ifundefined{@nBoard}{\examinergender[#1]}{}%
}%
%
\newcommand{\coadvisor}[3][]{%%
				\@ProfFields{coadvisor}{#1}{#2}{#3}%%
}%
\newcommand{\coadvisorinfo}[4]{%%
				\@ProfInfo{coadvisor}{#1}{#2}{#3}{#4}%%
}%
%
\newcommand{\coadvisorgender}[1][m]{%%
	\@ProfGender{coadvisor}{#1}%
}%
%
\DeclareRobustCommand{\examiner}[3][]{%%
        \stepcounter{TCC@examinercount}%%
				\@ProfFields{examiner\Alph{TCC@examinercount}}{#1}{#2}{#3}%%
}%
\newcommand{\examinerinfo}[4]{%%
				\@ProfInfo{examiner\Alph{TCC@examinercount}}{#1}{#2}{#3}{#4}%%
}%
\newcommand{\examinergender}[1][m]{%%
	\@ProfGender{examiner\Alph{TCC@examinercount}}{#1}%
}%
%
\newcounter{TCC@altexaminercount}[TCC@studentcount]%
\DeclareRobustCommand{\altexaminer}[3][]{%%
        \stepcounter{TCC@altexaminercount}%%
				\@ProfFields{altexaminer\Alph{TCC@altexaminercount}}{#1}{#2}{#3}%%
}%
\newcommand{\altexaminerinfo}[4]{%%
				\@ProfInfo{altexaminer\Alph{TCC@altexaminercount}}{#1}{#2}{#3}{#4}%%
}%
\newcommand{\altexaminergender}[1][m]{%%
	\@ProfGender{altexaminer\Alph{TCC@altexaminercount}}{#1}%
}%
%
\newcommand{\TCCpointsweight}[3]{%
	\gdef\@TCCpointAweight{#1}%
	\gdef\@TCCpointBweight{#2}%
	\gdef\@TCCpointCweight{#3}%
}%
\newcommand{\TCCpointslabel}[3]{%
	\gdef\@TCCpointAlabel{#1}%
	\gdef\@TCCpointBlabel{#2}%
	\gdef\@TCCpointClabel{#3}%
}%
%
\newcommand{\TCCgrades}[5]{%
	\gdef\@TCCgradeA{#1}%
	\gdef\@TCCgradeB{#2}%
	\gdef\@TCCgradeC{#3}%
	\gdef\@TCCgradeD{#4}%
  \gdef\@TCCgradeFF{#5}%
}%
%
\newcommand{\TCCgradesN}[3]{%
	\gdef\@TCCgradeAN{#1}%
	\gdef\@TCCgradeBN{#2}%
	\gdef\@TCCgradeCN{#3}%
}%
%
%
\newcommand{\examinergrades}[3]{%%
        \expandafter\def\csname @student\Alph{TCC@studentcount}@examiner\Alph{TCC@examinercount}pointA\endcsname{#1}%%
        \expandafter\def\csname @student\Alph{TCC@studentcount}@examiner\Alph{TCC@examinercount}pointB\endcsname{#2}%%
        \expandafter\def\csname @student\Alph{TCC@studentcount}@examiner\Alph{TCC@examinercount}pointC\endcsname{#3}%%
				\ifthenelse{\equal{#1}{}}{%%
					\expandafter\def\csname @student\Alph{TCC@studentcount}@examiner\Alph{TCC@examinercount}grade\endcsname{0}%
				}{%%
					\expandafter\FPeval\csname @student\Alph{TCC@studentcount}@examiner\Alph{TCC@examinercount}grade\endcsname{round((\@TCCpointAweight * #1 + \@TCCpointBweight * #2 + \@TCCpointCweight * #3):2) }%
				}%
	}%
%
\newcounter{TCC@calendareventcount}%
\newcommand{\tcccalendarevent}[2]{%%
        \stepcounter{TCC@calendareventcount}%%
        \expandafter\gdef\csname @tcccalendarevent\Alph{TCC@calendareventcount}week\endcsname{#1}%%
        \expandafter\gdef\csname @tcccalendarevent\Alph{TCC@calendareventcount}desc\endcsname{#2}%%
}%
\newcommand{\tcccalendarhead}[3]{\gdef\@tcccalendarhead{#1 & #2 & #3\\}}%
%
\newcounter{TCC@calendareventdatecount}%
\newcommand{\tcccalendareventdate}[1]{%%
        \stepcounter{TCC@calendareventdatecount}%%
        \expandafter\gdef\csname @tcccalendarevent\Alph{TCC@calendareventdatecount}date\endcsname{#1}%%
}%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%
%%% cover pages and related macros%
%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%
\newcommand{\@titlepagespecificinfo}{\@TCCspecificinfo}%
\newcommand{\@approvalspecificinfo}{\@TCCapproval}%
\newcommand{\sourcecitation}[1]{{\small{\sourcename\ #1.}}}%
%
%
\newlength{\formpagewinvoffset}\setlength{\formpagewinvoffset}{20mm}%
\newcommand\@formtopbox[3][]{%%
	\begin{center}%%
		\noindent%%
		\parbox[t]{\textwidth}{%%
      \centering%%
      \vbox to \formpagewinvoffset{%%
        \titlepagetopinfo%%
				{\sc #2}%
      }%%
    }%
		
		{\bf #3}\@ifundefined{#1}{}{\footnote[1]{\csname #1\endcsname}}%%
	\end{center}%%
}%
%
\newcommand{\titlepagetopinfo}{%%
        \@ifundefined{@university}{}{\MakeUppercase{\@university}\\}%
        \@ifundefined{@universitydivision}{}{\MakeUppercase{\@universitydivision}\\}%
        \@ifundefined{@course}{}{\MakeUppercase{\@course}\\}%
        \@ifundefined{@department}{}{\MakeUppercase{\@department}\\}%%
        \@ifundefined{@classname}{}{\MakeUppercase{\@classcode\ --\ \@classname}\\}%
        \@ifundefined{@subject}{}{\MakeUppercase{\@subject}}%
}%
\newcommand{\titlepageadvisorinfo}{%%
        \@ifundefined{@studentA@advisor}{}{\vfill{\@advisorname}:\null\ \@studentA@advisor}%
        \@ifundefined{@studentA@coadvisor}{}{\\[6ex]{\@coadvisorname}:\null\ \@studentA@coadvisor}%
}%
%
\newcommand{\reportpageadvisorinfo}{%%
        \@ifundefined{@studentA@advisor}{}{\vfill\MakeUppercase{\@ifundefined{@internship}{\@profname}{\@advisorname}}:\\\null\hfill\@studentA@advisor}%
        \@ifundefined{@studentA@coadvisor}{}{\\[6ex]\MakeUppercase{\@ifundefined{@internship}{\@coprofname}{\@coadvisorname}}:\\\null\hfill\@studentA@coadvisor}%
}%
%
%
%%%%%%%%%%%%%%%%%%%
\newcommand{\coverpages}{%%
	\@makecover%that´s the first page%
	\@ifundefined{@report}{%%
    \thetitlepage%that´s the second page (for tcc)%
    \@makeapprovalpage%that´s the third page (for tcc)%
%%%		\@makecippage%
	}{}%
}%
%
\renewcommand{\maketitle}{\coverpages}%
%
%
%%%%%%%%%
%%%
%% 1st cover page%
%%%
%%%%%%%%%
\newcommand{\@makecover}{%%
  \begin{titlepage}%
    \noindent\@covertopbox%
    \vfill%
	  \@ifundefined{@report}{}{%%
		  \@ifundefined{@studentA@advisor}{}{%%
        \hspace*{\fill}\parbox[b]{\@advisorwidth}{\reportpageadvisorinfo}%
			  \vfill%
      }%%
	  }%%
    \centerline{\@city}%
	  \centerline{\@publyear}%
  \end{titlepage}%%
	\if@openright\cleardoublepage\else\clearpage\fi%%
}%
%
\def\@covertopbox{%%
  \parbox[t]{\textwidth}{%%
    \centering%%
    \vbox to \titlepagewinvoffset{%%
      \titlepagetopinfo\vfill\@winbox%
    }%
  }%
}%
%
%%%%%%%%%
%%%
%% 2nd cover page (title page)%
%%%
%%%%%%%%%
\newcommand{\thetitlepage}{%%
	\begin{titlepage}%
    \noindent\@titlepagetopbox%
    \vfill%
    \@ifundefined{@titlepagespecificinfo}{}{%
      \hspace*{\fill}\makebox[.55\textwidth][l]{%%
        \hyphenpenalty 10000 \parbox[b]{8.5cm}{\@titlepagespecificinfo}%%
      }%
      \vfill%
    }%
    \@ifundefined{@studentA@advisor}{}{%
      \hspace*{\fill}\parbox[b]{\@advisorwidth}{%%
        \begin{flushright}
        \titlepageadvisorinfo%
        \end{flushright}
      }%
      \vfill%
    }%
    \centerline{\@city}%
	  \centerline{\@publyear}%
	\end{titlepage}%
	\if@openright\cleardoublepage\setcounter{page}{3}\else\clearpage\setcounter{page}{2}\fi%%
}%
%
%
\def\@titlepagetopbox{%%
  \parbox[t]{\textwidth}{%%
    \centering%%
%                \vbox to \titlepagewinvoffset{%%
		\@winbox%
%                }%
  }%
}%
%
%
%\newcommand{\@studentdesc}[1]{\@ifundefined{#1}{}{\MakeUppercase{\textbf{\csname #1\endcsname\ -- \csname #1ID\endcsname}}\\}}
\newcommand{\@studentdesc}[1]{\@ifundefined{#1}{}{\MakeUppercase{\textbf{\csname #1\endcsname\ }}\\}} %Removi o número de matrícula :)
\def\@winbox{%%
%       \fbox{%
    \parbox[b]{\titlepagewinwidth}{%%
    \centering\vbox to \titlepagewinheight{%%
      \vspace*{\fill}%
			\@ifundefined{@report}{\@studentdesc{@studentA}}{%
			\@studentdesc{@studentA}%
      \@studentdesc{@studentB}%
      \@studentdesc{@studentC}%
      \@studentdesc{@studentD}}%%
      \vspace{\stretch{4}}%
      {\large\MakeUppercase{\textbf{\@title}}\par}%
      \vfill%
    }%%
	}%%
%       }%%
}%
%
%%%%%%%%%
%%%
%% 3rd cover page (approval page)%
%%%
%%%%%%%%%
\newcommand{\@makeapprovalpage}{%%
	\@ifundefined{@TCCest}{\@theapprovalpage}{\@approvalspecificinfo}%
	\if@openright\cleardoublepage\else\clearpage\fi%%
}%
%
\newcommand{\@theapprovalpage}{%%
	\begin{center}%
    \noindent\@titlepagetopbox%
    \vfill%
    \@ifundefined{@approvalspecificinfo}{}{%
      \hspace*{\fill}\makebox[.55\textwidth][l]{%%
        \hyphenpenalty 10000 \parbox[b]{8.5cm}{\@approvalspecificinfo}%%
      }%
      \vfill%
    }%
    \@ifundefined{@studentA@advisor}{}{%
        \hspace*{\fill}\parbox[b]{1.0\textwidth}{\@advisoringname:}%
        \vfill%
    \hspace*{\fill}\parbox[b]{.90\textwidth}{%%
      \@approvalpageadvisorinfo%
    }%
    \vfill%
    }%
	\@ifundefined{@studentA@examinerA}{}{%
		\hspace*{\fill}\parbox[b]{1.0\textwidth}{\@examinername:}%
		\vfill%
    \hspace*{\fill}\parbox[b]{.90\textwidth}{%%
      \@approvalpageexaminerinfo%
    }%
    \vfill%
    }%
    \@ifundefined{@coursecoord}{}{%
    	\hspace*{\fill}\parbox[b]{1.0\textwidth}{\@coordname:}%
		\vfill%
    \hspace*{\fill}\parbox[b]{.90\textwidth}{%%
      \@approvalpagecoordinfo%
    }%
    \vfill%
    }%
  \vfill%
  \hfill\@city, \TCC@date%
	\end{center}%
}%
%
\newcommand{\@approvalpageadvisorinfo}{%%
  \@ifundefined{@studentA@advisor}{}{%%
		\vfill%
		%\@advisorname: \hrulefill\\%
		\@studentA@advisor, \@studentA@advisorinstitution\\%
		\@studentA@advisortitleinfo %
	}%  
	\@ifundefined{@studentA@coadvisor}{}{%%
		\\\vfill%
		%\@advisorname: \hrulefill\\%
		\@studentA@coadvisor, \@studentA@coadvisorinstitution\\%
		\@studentA@coadvisortitleinfo %
	}%
}%
\newcommand{\@@aprovalexaminerinfo}[1]{
  \@ifundefined{#1}{}{%%
  	\csname #1\endcsname, \csname #1institution\endcsname\\%
		\csname #1titleinfo\endcsname\\%
	}%
}%
\newcommand{\@approvalpageexaminerinfo}{%%
		\vfill%
        \@@aprovalexaminerinfo{@studentA@examinerB}%

		\@@aprovalexaminerinfo{@studentA@examinerC}%

		\@@aprovalexaminerinfo{@studentA@examinerD}%

		\@@aprovalexaminerinfo{@studentA@examinerE}%
		
		\@@aprovalexaminerinfo{@studentA@examinerA}%
}%
%
\newcommand{\@approvalpagecoordinfo}{%%
  \@ifundefined{@coursecoord}{}{%%
		\vfill%
		\@coursecoord\\%
		\@coursecoordtitle %
	}%
}%
%
%
%
%==============================================================================%
% Catalogação na fonte (CIP) e nominata%
%==============================================================================%
\newcommand{\@makecippage}{%%
        \clearpage%%
        \begin{center}%
                \textbf{\cipcaption}\\[2ex]%
                \TCCu@cipwindow%
        \end{center}%
        \vfill%
%        \nominata%
}%
% definição do quadro%
\def\TCCu@cipwindow{%%
        \framebox[120mm]{%%
        \begin{minipage}{110mm}%%
                \vspace*{0.2ex}%
                \setlength{\parindent}{1.5em}%%
                \setlength{\parskip}{1.3ex}%%
                \noindent\@studentAlast, \@studentAfirst\par%
                \@title\ / \@studentA.\ -- \@city: \@cipunit, \@publyear.\par%
                \pageref{LastPage}~f.: il.\par%
                \@cipspecificinfo\ -- \@universityacronym. \@course, \@city, BR--\@state, \@publyear. \@advisorname: \@studentA@advisorfirst\ \@studentA@advisorlast\@ifundefined{@studentA@coadvisor}{}{; \@coadvisorname: \@studentA@coadvisorfirst\ \@studentA@coadvisorlast}.\par%
                \@cipkw I.~\@studentA@advisorlast, \@studentA@advisorfirst. \@ifundefined{@studentA@coadvisorfirst}{II.~T\'{\i}tulo.}{II.~\@studentA@coadvisorlast, \@studentA@coadvisorfirst. III.~T\'{\i}tulo.}\\%
                \vspace{0.2ex}%
        \end{minipage}%%
        }%%
}%
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Examiner´s form%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\examinersforms}{%
	\@examiners{examinerA}%
	\@examinersform{examinerA}%
	\@reviewform{examinerA}%
	\@examiners{examinerB}%
	\@examinersform{examinerB}%
	\@reviewform{examinerB}%
	\@examiners{examinerC}%
	\@examinersform{examinerC}%
	\@reviewform{examinerC}%
	\@examiners{altexaminerA}%
	\@examinersform{altexaminerA}%
	\@reviewform{altexaminerA}%
}%
%
\newcommand{\@examinerforms}[1]{%
	\@examinersform{#1}%
	\@reviewform{#1}%
}%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% student list form%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\studentlistform}{%
  \@studentlistform%
}%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Board approval forms%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\examboardform}{%
  \@examboardform%
}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% rectify approval form%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\rectifyapprovalform}{%
  \@rectifyapprovalform%
}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Advisor approval (for presentation) form%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\advisorapprovalform}{%
  \@advisorapprovalform%
}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Requirement renew form%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\renewreqform}{%
  \@renewreqform%
}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Requirement form%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\reqform}{%
  \@reqform%
}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Co-advisor Requirement form%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\coadvisorform}{%
  \@coadvisorform%
}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Board reciept forms%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\recieptforms}{%
	\@recieptform{examinerA}%
	\@recieptform{examinerB}%
	\@recieptform{examinerC}%
	\@recieptform{altexaminerA}%
}%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% student commands%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\tccbrief}[1]{\gdef\@tccbrief{#1}}%
\newcommand{\tcccoadvisorbrief}[1]{\gdef\@tcccoadvisorbrief{#1}}%
\newcommand{\tccadvisorsreview}[1]{\gdef\@tccadvisorsreview{#1}}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Aux commands%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@formsigdate}[1]{%%
	\begin{flushright} \@formlocal %
		~\vspace*{6mm}\\%
%
		$\overline{#1}$%%
	\end{flushright}%
}%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% examiners description (for Board approval forms)%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@examinerdesc}[3][\@formsexaminerlabel]{%%
 \@examiners{#3}%
 \@ifundefined{@#2@#3}{--}{#1: {\bf \csname @#2@#3\endcsname}%

 \hfill \@formsemaillabel: {\bf \csname @#2@#3email\endcsname}  ~\@formsphonelabel: {\bf \csname @#2@#3phone\endcsname} ~\@agreelabel: \rule{\@agreerule}{.1pt}\\}%
}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% TCC description (for many forms)%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@tccdesc}{%%
	\@formsstudentlabel : {\bf \@studentA} \hfill \@formsstudentIDlabel : {\bf \@studentAID}%

	\@formsworktitlelabel : {\bf \@title}\\[-4mm]%

	\@formsadvisorlabel : {\bf \@studentA@advisor}\\%
}%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% TCC calendar%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@calendartab{11.5cm}%
\newcommand{\@TCCcalendarline}[1]{\@ifundefined{@tcccalendarevent#1week}{}{\textbf{\csname @tcccalendarevent#1date\endcsname} & \csname @tcccalendarevent#1week\endcsname & \csname @tcccalendarevent#1desc\endcsname\\\hline}}%
%%%
%%
%%%
\newcommand{\@TCCcalendar}{%
	\@formtopbox{\@formstitle}{\@calendartitle}%
%
	{ \footnotesize%
		\begin{center}
%
			\resizebox{\textwidth}{!}{%%
				\begin{tabular}{ccp{\@calendartab}}%
					\@tcccalendarhead\hline%
					\@TCCcalendarline{A}%
					\@TCCcalendarline{B}%
					\@TCCcalendarline{C}%
					\@TCCcalendarline{D}%
					\@TCCcalendarline{E}%
					\@TCCcalendarline{F}%
					\@TCCcalendarline{G}%
					\@TCCcalendarline{H}%
					\@TCCcalendarline{I}%
					\@TCCcalendarline{J}%
					\@TCCcalendarline{K}%
					\@TCCcalendarline{L}%
					\@TCCcalendarline{M}%
					\@TCCcalendarline{N}%
					\@TCCcalendarline{O}%
				\end{tabular}}
%
		\end{center}%
    \if@lmodern		
			\tiny
		\fi
		\@tcccalendardesc%
	}%
	\vfill%
%
	\pagebreak%
}%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Student list form%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@stlistrule{65mm}%
\def\@stlisttab{70mm}%
%%%
%%
%%%
\newcommand{\@studentlistrow}[1]{%%
	\@ifundefined{@student#1}{\rule{\@stlistrule}{.1pt}}{\csname @student#1\endcsname}\hrulefill & \rule{\@stlistrule}{.1pt}\\%
}%
%
\newcommand{\@studentlistform}{%
  \stepcounter{TCC@studentcount}%
	\@formtopbox{\@formstitle}{\@studentlistformtitle}%
	\vspace{20mm}%
%
	{\small%
	\begin{tabular}{p{\@stlisttab}@{ }p{\@stlisttab}}%
	\@formsstudentlabelgen & \@studentsignaturegen\\\hline\\[2mm]%
	
%
	\@studentlistrow{A}
%
	\@studentlistrow{B}%
	\@studentlistrow{C}%
	\@studentlistrow{D}%
	\@studentlistrow{E}%
%
	\@studentlistrow{F}%
	\@studentlistrow{G}%
	\@studentlistrow{H}%
	\@studentlistrow{I}%
	\@studentlistrow{J}%
%
	\@studentlistrow{K}%
	\@studentlistrow{L}%
	\@studentlistrow{M}%
	\@studentlistrow{N}%
	\@studentlistrow{O}%
%
	\@studentlistrow{P}%
	\@studentlistrow{Q}%
	\@studentlistrow{R}%
	\@studentlistrow{S}%
	\@studentlistrow{T}%
%
	\@studentlistrow{U}%
	\@studentlistrow{V}%
	\@studentlistrow{W}%
	\@studentlistrow{X}%
	\@studentlistrow{Y}%
	\end{tabular}}%
	\vfill%
%
	\pagebreak%
}%
%
%%%
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% student info row (for reports and referral letters)%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@BoardTabA{38mm}%
\def\@BoardTabB{38mm}%
\def\@BoardTabC{60mm}%
\def\@BoardTabD{13mm}%
%%%
%%
%%%
\newcommand{\@studentboardrow}[1]{%%
	\@ifundefined{@student#1}{}{%
		\@ifundefined{@student#1Dismiss}{%%
			\@ifundefined{@student#1FF}{%%
				\@ifundefined{@student#1time}{}{%%
					\multirow{4}{\@BoardTabA}{\textbf{\csname @student#1\endcsname}}  & \multirow{4}{\@BoardTabB}{{\csname @student#1@advisor\endcsname}} & \csname @student#1@examinerA\endcsname  & \multirow{5}{\@BoardTabD}{\if@coord@boarddates\else\csname @student#1date\endcsname\\\fi
						 \csname @student#1time\endcsname\\[1mm]\csname @student#1local\endcsname
						}\\*%
					& & \csname @student#1@examinerB\endcsname & \\*%
					& & \csname @student#1@examinerC\endcsname & \\*%
					& & (\csname @student#1@altexaminerA\endcsname\ ) & \\*%
					\multicolumn{3}{l}{\textsc{\@boardsworklabel:} \begin{minipage}{0.90\textwidth}\textit{\csname @student#1title\endcsname}\end{minipage}} & \\[2mm]\hline%
				}%
			}{}%
		}{}%
	}%
}%
%
\newcommand{\@testdaterow}[2]{%%
%	\@ifundefined{@coord@boarddates}{}{%%
	\if@coord@boarddates
		\@ifundefined{@student#2}{}{%%
			\@ifundefined{@student#2Dismiss}{%%
				\@ifundefined{@student#2FF}{%%
					\@ifundefined{@student#2BoardsNP}{%%
						\@@testdaterow{\csname @student#1date\endcsname}{\csname @student#2date\endcsname}%%
					}{\pagebreak\@daterow{#2}}%%
				}{}%%
			}{}%%
		}%%
	\fi	
	%}%%@boarddates
}%%
%
\newcommand{\@@testdaterow}[2]{\ifthenelse{\equal{#1}{#2}}{\\[-4.35mm]\hline\\[-4mm]}{\@@daterow{#2}}}%
\newcommand{\@daterow}[1]{\gdef\@date{\csname @student#1date\endcsname}\@@daterow{\@date}}%
\newcommand{\@@daterow}[1]{& & \multicolumn{2}{r}{\textsc{\textbf{\csname date:#1\endcsname\ --- #1}}} \\*%
					\textsc{\@formsstudentlabelgen} & \textsc{\@formsadvisorlabelgen} & \textsc{\@formsboardtitle} & \textsc{\@formstimelabel}\\*\hline}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% TCC Boards announce table%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@TCCboards}{%
  \stepcounter{TCC@studentcount}%
	\@formtopbox{\@formstitle}{\@TCCperiod}%
%
	{%%
		\footnotesize\gdef\@date{\csname @studentAdate\endcsname}%
		\setlength\LTleft{-8mm} \begin{center}%
			{%%
				\begin{longtable}{p{\@BoardTabA}p{\@BoardTabB}p{\@BoardTabC}p{\@BoardTabD}}%
					\multicolumn{4}{c}{\textbf{\textsc{\@boardstitle}}}\\\hline%
					%\@ifundefined{@coord@boarddates}{\textsc{\@formsstudentlabelgen} & \textsc{\@formsadvisorlabelgen} & \textsc{\@formsboardtitle} & \textsc{\@formstimelabel}\\\hline}{}%
					\if@coord@boarddates\else\textsc{\@formsstudentlabelgen} & \textsc{\@formsadvisorlabelgen} & \textsc{\@formsboardtitle} & \textsc{\@formstimelabel}\\\hline\fi%
					\endhead%
																				\@testdaterow{T}{A}%
					\@studentboardrow{A}					\@testdaterow{A}{B}%
					\@studentboardrow{B}					\@testdaterow{B}{C}%
					\@studentboardrow{C}					\@testdaterow{C}{D}%
					\@studentboardrow{D}					\@testdaterow{D}{E}%
					\@studentboardrow{E}					\@testdaterow{E}{F}%
%
					\@studentboardrow{F}					\@testdaterow{F}{G}%
					\@studentboardrow{G}					\@testdaterow{G}{H}%
					\@studentboardrow{H}					\@testdaterow{H}{I}%
					\@studentboardrow{I}					\@testdaterow{I}{J}%
					\@studentboardrow{J}					\@testdaterow{J}{K}%
%
					\@studentboardrow{K}					\@testdaterow{K}{L}%
					\@studentboardrow{L}					\@testdaterow{L}{M}%
					\@studentboardrow{M}					\@testdaterow{M}{N}%
					\@studentboardrow{N}					\@testdaterow{N}{O}%
					\@studentboardrow{O}					\@testdaterow{O}{P}%
%
					\@studentboardrow{P}					\@testdaterow{P}{Q}%
					\@studentboardrow{Q}					\@testdaterow{Q}{R}%
					\@studentboardrow{R}					\@testdaterow{R}{S}%
					\@studentboardrow{S}					\@testdaterow{S}{T}%
					\@studentboardrow{T}%
%
				\end{longtable}%
			}%
		\end{center}%
		{\bf \@boardsOBS}%
	}%
	\vfill%
	\pagebreak%
}%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% \@fate => A,B,C,D as a function of student grade%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@fate}[1]{\FPiflt{#1}{\@TCCgradeCN} \@TCCgradeD\else\FPiflt{#1}{\@TCCgradeBN} \@TCCgradeC\else\FPiflt{#1}{\@TCCgradeAN} \@TCCgradeB\else \@TCCgradeA\fi}%
\newcommand{\@@fate}[1]{\@fate{\csname @student#1Temp\endcsname}}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% \@student grade => average of the 3 examiners grade%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@studentgrade}[1]{%%
	\@ifundefined{@student#1}{}{%
		\expandafter\FPeval\csname @student#1Temp\endcsname{%%
round((\csname @student#1@examinerAgrade\endcsname + \csname @student#1@examinerBgrade\endcsname + \csname @student#1@examinerCgrade\endcsname)/3:2)%
		}%
	}%
}%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% examiners info (grades) for report/referral letters%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@examinersline}[2]{%%
& \csname @student#1@examiner#2\endcsname & \csname @student#1@examiner#2pointA\endcsname & \csname @student#1@examiner#2pointB\endcsname & \csname @student#1@examiner#2pointC\endcsname & \csname @student#1@examiner#2grade\endcsname &%
}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% student extra info (process number, ID, email) for report%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@studentextrainfo}[1]{%%
	 (\csname @student#1Nproc\endcsname )\  \ \csname @student#1ID\endcsname\ / \csname @student#1email\endcsname%%
}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% student info (all examiners, advisor, etc.) for report and referral letters.%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@studentrow}[2][]{%%
	\@ifundefined{@student#2}{}{%%
		\@ifundefined{@student#2FF}{%%
			\@ifundefined{@student#2Dismiss}{%%
				\multirow{4}{\@ReportTabA}{\csname @student#2\endcsname} %%
				\@examinersline{#2}{A}\\*%%
				\@examinersline{#2}{B}\\*%%
				\@examinersline{#2}{C}\\*%%
				& \multicolumn{4}{c}{\@advisorname : \csname @student#2@advisor\endcsname} & \textbf{\csname @student#2Temp\endcsname} & %%
					\textbf{\@@fate{#2}}%%
					\@ifundefined{#1}{\\}{\\*%%
						\multicolumn{6}{l}{\@boardsworklabel: \csname @student#2title\endcsname}\\*%%
						\multicolumn{6}{l}{\@studentextrainfo{#2}}\\*%
						\multicolumn{6}{c}{{\bf \csname @student#2remark\endcsname}}\\%
					}%%
					\hline%%
			}{%%
			}%%
		}{%%
		}%%
	}%%
}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% student FF info (report)%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@studentFFrow}[1]{%%
	\@ifundefined{@student#1}{}{%%
		\@ifundefined{@student#1Dismiss}{%%
			\@ifundefined{@student#1FF}{%%
			}{%%
				\multicolumn{6}{l}{\csname @student#1\endcsname }  & \@TCCgradeFF\\*%%
				\multicolumn{6}{l}{\@studentextrainfo{#1} }  & \\*%%
				\multicolumn{6}{l}{\@advisorname : \csname @student#1@advisor\endcsname} & \\\hline%%
			}%%
		}{}%%
	}%%
}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% student info (report), dimiss case%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@studentDismissrow}[1]{%%
	\@ifundefined{@student#1}{}{%%
		\@ifundefined{@student#1FF}{%%
			\@ifundefined{@student#1Dismiss}{%%
			}{%%
				\multicolumn{6}{l}{\csname @student#1\endcsname} & \\*%%
				\multicolumn{6}{l}{\@studentextrainfo{#1} } & \\*%%
				\multicolumn{6}{l}{\@advisorname : \csname @student#1@advisor\endcsname} & \\\hline%%
			}%%
		}{}%%
	}%%
}%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% TCC report (student grades, FF, dismiss)%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@ReportTabA{32mm}%
\def\@ReportTabB{42mm}%
\def\@ReportTabC{15mm}%
\def\@ReportTabD{15mm}%
\def\@ReportTabE{15mm}%
\def\@ReportTabF{8mm}%
\def\@ReportTabG{12mm}%
%%%%
%%
%%%%
\newcommand{\@TCCreport}{%
  \stepcounter{TCC@studentcount}%
	\@formtopbox{\@formstitle}{\@tccreporttitle\ - \@TCCperiod}%
	{%%
%		\footnotesize%
		\tiny%
%%
		\@studentgrade{A}%
		\@studentgrade{B}%
		\@studentgrade{C}%
		\@studentgrade{D}%
		\@studentgrade{E}%
		\@studentgrade{F}%
		\@studentgrade{G}%
		\@studentgrade{H}%
%%
		\@studentgrade{I}%
		\@studentgrade{J}%
		\@studentgrade{K}%
		\@studentgrade{L}%
		\@studentgrade{M}%
		\@studentgrade{N}%
		\@studentgrade{O}%
		\@studentgrade{P}%
%%
		\@studentgrade{Q}%
		\@studentgrade{R}%
		\@studentgrade{S}%
		\@studentgrade{T}%
		\@studentgrade{U}%
		\@studentgrade{V}%
		\@studentgrade{W}%
		\@studentgrade{X}%
%%
		\begin{center}%
				\begin{longtable}{p{\@ReportTabA}@{\ }p{\@ReportTabB}@{\ }p{\@ReportTabC}@{\ }p{\@ReportTabD}@{\ }p{\@ReportTabE}@{\ }p{\@ReportTabF}@{\ }p{\@ReportTabG}}%
					\multicolumn{7}{c}{\@formstitle\ \@TCCperiod}\\\hline%
					& \@boardlabel & \@TCCpointAlabel & \@TCCpointBlabel & \@TCCpointClabel &%
						\@TCCgradesNlabel & \@TCCgradesClabel\\\hline%
					\endhead%
					\@studentrow[@studentextrainfo]{A}%
					\@studentrow[@studentextrainfo]{B}%
					\@studentrow[@studentextrainfo]{C}%
					\@studentrow[@studentextrainfo]{D}%
					\@studentrow[@studentextrainfo]{E}%
					\@studentrow[@studentextrainfo]{F}%
					\@studentrow[@studentextrainfo]{G}%
					\@studentrow[@studentextrainfo]{H}%
%%
					\@studentrow[@studentextrainfo]{I}%
					\@studentrow[@studentextrainfo]{J}%
					\@studentrow[@studentextrainfo]{K}%
					\@studentrow[@studentextrainfo]{L}%
					\@studentrow[@studentextrainfo]{M}%
					\@studentrow[@studentextrainfo]{N}%
					\@studentrow[@studentextrainfo]{O}%
					\@studentrow[@studentextrainfo]{P}%
%%
					\@studentrow[@studentextrainfo]{Q}%
					\@studentrow[@studentextrainfo]{R}%
					\@studentrow[@studentextrainfo]{S}%
					\@studentrow[@studentextrainfo]{T}%
					\@studentrow[@studentextrainfo]{U}%
					\@studentrow[@studentextrainfo]{V}%
					\@studentrow[@studentextrainfo]{W}%
					\@studentrow[@studentextrainfo]{X}%
					\@ifundefined{@TCCff@flag}{}{%
						& & & & & & \\%
						& & & & & & \\%
						\multicolumn{6}{l}{{\bf \@tccreportabsents}}\\\hline%
						\@studentFFrow{A}%
						\@studentFFrow{B}%
						\@studentFFrow{C}%
						\@studentFFrow{D}%
						\@studentFFrow{E}%
						\@studentFFrow{F}%
						\@studentFFrow{G}%
						\@studentFFrow{H}%
%%
						\@studentFFrow{I}%
						\@studentFFrow{J}%
						\@studentFFrow{K}%
						\@studentFFrow{L}%
						\@studentFFrow{M}%
						\@studentFFrow{N}%
						\@studentFFrow{O}%
						\@studentFFrow{P}%
%%
						\@studentFFrow{Q}%
						\@studentFFrow{R}%
						\@studentFFrow{S}%
						\@studentFFrow{T}%
						\@studentFFrow{U}%
						\@studentFFrow{V}%
						\@studentFFrow{W}%
						\@studentFFrow{X}%
					}%
					\@ifundefined{@TCCdismiss@flag}{}{%
						& & & & & & \\%
						& & & & & & \\%
						\multicolumn{6}{l}{{\bf \@tccreportdismiss}}\\\hline%
						\@studentDismissrow{A}%
						\@studentDismissrow{B}%
						\@studentDismissrow{C}%
						\@studentDismissrow{D}%
						\@studentDismissrow{E}%
						\@studentDismissrow{F}%
						\@studentDismissrow{G}%
						\@studentDismissrow{H}%
%%
						\@studentDismissrow{I}%
						\@studentDismissrow{J}%
						\@studentDismissrow{K}%
						\@studentDismissrow{L}%
						\@studentDismissrow{M}%
						\@studentDismissrow{N}%
						\@studentDismissrow{O}%
						\@studentDismissrow{P}%
%%
						\@studentDismissrow{Q}%
						\@studentDismissrow{R}%
						\@studentDismissrow{S}%
						\@studentDismissrow{T}%
						\@studentDismissrow{U}%
						\@studentDismissrow{V}%
						\@studentDismissrow{W}%
						\@studentDismissrow{X}%
					}%%
				\end{longtable}%%
		\end{center}%%
	} %end of footnotesize%

	\vfill%
	\pagebreak%
}%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% student check list row%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@studentcheckrow}[1]{%%
	\@ifundefined{@student#1}{}{%%
		\@ifundefined{@student#1FF}{%%
			\@ifundefined{@student#1Dismiss}{%%
				\multirow{4}{\@ReportTabA}{\csname @student#1\endcsname} %
							& \@check{#1}{checkAA} &  \@check{#1}{checkAB} & \@check{#1}{checkAC} & \@check{#1}{checkAD} & \@check{#1}{checkAE}\\*%
							& \@check{#1}{checkBA} &  \@check{#1}{checkBB} & \@check{#1}{checkBC} & \@check{#1}{checkBD} & \@check{#1}{checkBE}\\*%
							& \@check{#1}{checkCA} &  \@check{#1}{checkCB} & \@check{#1}{checkCC} & \@check{#1}{checkCD} & \@check{#1}{checkCE}\\*%
							& \@check{#1}{checkDA} &  \@check{#1}{checkDB} & \@check{#1}{checkDC} & \@check{#1}{checkDD} & \@check{#1}{checkDE}\\\hline%%
			}{}%%
		}{}%%
	}%%
}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% TCC check list%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@TCCchecklist}{%
  \stepcounter{TCC@studentcount}%
	\@formtopbox{\@formstitle}{Check List - \@TCCperiod}%
	{%%
%		\footnotesize%
		\scriptsize%
		\setlength\LTleft{-10mm}%
		\begin{center}%
				\begin{longtable}{p{\@ReportTabA}lllll}%
					\\\hline%
					\endhead%
					\@studentcheckrow{A}%
					\@studentcheckrow{B}%
					\@studentcheckrow{C}%
					\@studentcheckrow{D}%
					\@studentcheckrow{E}%
					\@studentcheckrow{F}%
					\@studentcheckrow{G}%
					\@studentcheckrow{H}%
%%
					\@studentcheckrow{I}%
					\@studentcheckrow{J}%
					\@studentcheckrow{K}%
					\@studentcheckrow{L}%
					\@studentcheckrow{M}%
					\@studentcheckrow{N}%
					\@studentcheckrow{O}%
					\@studentcheckrow{P}%
%%
					\@studentcheckrow{Q}%
					\@studentcheckrow{R}%
					\@studentcheckrow{S}%
					\@studentcheckrow{T}%
					\@studentcheckrow{U}%
					\@studentcheckrow{V}%
					\@studentcheckrow{W}%
					\@studentcheckrow{X}%
				\end{longtable}%%
		\end{center}%%
	} %end of footnotesize%

	\vfill%
	\pagebreak%
}%
%
%
%
%
%
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
%
%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% referral fate :: failed or approved as per student grade%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@referralfate}[1]{\FPiflt{#1}{\@TCCgradeCN} \@referralfailed\else\@referralapproved\fi}%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% TCC referral letters :: approved/failed/FF%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@TCCreferralletter}{%
	\@ifundefined{@student\Alph{TCC@studentcount}Dismiss}{%
		\@formtopbox{\@formstitle}{\@TCCperiod}%

		\noindent\@tccreferralopening%
		\vfill%

		\@ifundefined{@student\Alph{TCC@studentcount}FF}{%
			\@ifundefined{@student\Alph{TCC@studentcount}Exam}{%
				\@studentgrade{\Alph{TCC@studentcount}}%
				 \@referralfatetext%

				\vfill%

				{\footnotesize%
					\begin{center}%
						\resizebox{\textwidth}{!}{%
							\begin{tabular}{p{\@ReportTabA}@{\ }p{\@ReportTabB}@{\ }c@{\ }c@{\ }c@{\ }c@{\ }c}%\hline%
								& \@boardlabel & \@TCCpointAlabel & \@TCCpointBlabel & \@TCCpointClabel &%
								\@TCCgradesNlabel & \@TCCgradesClabel\\\hline%
								\@studentrow{\Alph{TCC@studentcount}}%
		%\@ifundefined{@TCCff@flag}{}{%
		%	\multicolumn{6}{l}{{\bf \@tccreportabsents}}\\\hline%
		%	\@studentFFrow{\Alph{TCC@studentcount}}{}%
		%}%
							\end{tabular}%
						}%
					\end{center}%
				}%
			}{%
				\ifthenelse{\equal{\csname @student\Alph{TCC@studentcount}Exam\endcsname}{D}}{%
					\@referralexamfailtext%
					\vfill%
				}{%
					\@referralexamapprovedtext%
					\vfill%
				}%
				{%%
					\footnotesize%
					\begin{center}%
						\begin{tabular}{p{\@ReportTabA}@{\ }p{\@ReportTabB}@{\ }c}%\hline%
							& \@boardlabel \\\hline%
							\multirow{3}{\@ReportTabA}{\csname @student\Alph{TCC@studentcount}\endcsname} %
							&\csname @student\Alph{TCC@studentcount}@examinerA\endcsname\\%
							&\csname @student\Alph{TCC@studentcount}@examinerB\endcsname\\%
							&\csname @student\Alph{TCC@studentcount}@examinerC\endcsname\\%
							\multicolumn{2}{l}{\@formsadvisorlabel : \csname @student\Alph{TCC@studentcount}@advisor\endcsname} \\\hline%
						\end{tabular}%
					\end{center}%
				}%
			}%
		}{%
			\@referralfailFF%
		}%

		\vfill%
		\begin{flushright}%
			\@city, \@publday\ de \@publmonth\ de \@publyear .%
			\vfill %

			\@TCCcoordtitle%
			\vfill%

			$\overline{\text{\@TCCcoord}}$%
		\end{flushright}%
		\vfill%
		\pagebreak%
	}{}%
}%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% TCC examine´s form (grades)%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@examinersform}[1]{%
	\@formtopbox[@formsfootnote]{\@formstitle}{\@examformtitle}%
%
	\vfill%
	\@formsstudentlabel : {\bf \csname @student\Alph{TCC@studentcount}\endcsname}\\%
	\@formsexaminerlabel :  \csname @student\Alph{TCC@studentcount}@#1\endcsname%
	\vfill%
	\@examformdesc%

	\vfill%

	\begin{center}
		\begin{tabular}{|c|c|c|}%
			\hline%
			\@TCCpointAlabel & \@TCCpointBlabel & \@TCCpointClabel \\\hline%
			& & \\\hline
		\end{tabular}%
	\end{center}%

	\vfill%

	\@formsigdate{\@examinersignature}%
	\vfill%
	\begin{description}
		\item[\@examformnoteslabel:] \@examformnotes
	\end{description}%

	\vfill%
	\pagebreak%
}%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% TCC examiners review´s form (corrections)%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@reviewform}[1]{%
	\@formtopbox[@reviewformfootnote]{\@formstitle}{\@reviewformtitle}%

	\vfill%
	\@formsstudentlabel : {\bf \expandafter\csname @student\Alph{TCC@studentcount}\endcsname}\\%
	\@formsexaminerlabel : \expandafter\csname @student\Alph{TCC@studentcount}@#1\endcsname%
	\vfill%
	\resizebox{0.9\textwidth}{!}{%%
		\@reviewformdesc%
	}%
	\footnotetext[2]{\@reviewformfootnoteB}%
	\vfill%

	\@formsigdate{\@examinersignature}%
	\vfill%
	\pagebreak%
}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% TCC requirement form (TCC register)%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@reqform}{%
	\@formtopbox{\@formstitle}{\@reqformtitle}%

	\vfill%

	\@reqformopening%
	\vfill%

	\@reqformdesc%
	\vfill%

	\@formstemptitlelabel : \@title %

	\@formsstudentemaillabel : {\bf \@studentAemail} %

	\@formsadvisorlabel : \@studentA@advisor%

	\@formsadvisoremaillabel : {\bf \@studentA@advisoremail}%
	\hfill \@formsphonelabel : {\bf \@studentA@advisorphone}%

	{\bf \@formsbrieflabel}:\footnote[1]{\@renewreqformnotes}%

  \vfill%
	\@tccbrief%

	\parbox[t]{.45\textwidth}{\@formsigdate{\@studentsignature}}\hfill%
	\parbox[t]{.45\textwidth}{\@formsigdate{\@advisorsignature}}%
	\pagebreak%
}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% TCC requirement form (TCC register)%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@coadvisorform}{%
	\@ifundefined{@studentA@coadvisor}{%
		\coadvisor{\rule{\@namerule}{.1pt}}{}%
		\coadvisorinfo{}{\rule{\@titlerule}{.1pt}}{\rule{\@emailrule}{.1pt}}{\rule{\@phonerule}{.1pt}}%
		}{}%
	\@formtopbox{\@formstitle}{\@coadvisorformtitle}%

	\vfill%

	\@reqformopening%
	\vfill%

	\@coadvisorformdesc%
	\vfill%

	\@formstemptitlelabel : \@title %

	\@formsadvisorlabel: \@studentA@advisor 
	
	\@formscoadvisorlabel: \@studentA@coadvisor%

  \vfill%
	{\bf \@formsreasonlabel}:%

	\@tcccoadvisorbrief%

	\@formsigdate{\@studentsignature}%
	
	\parbox[t]{.45\textwidth}{\@formsigdate{\@advisorsignature}}\hfill%
	\parbox[t]{.45\textwidth}{\@formsigdate{\@coadvisorsignature}}%
	\pagebreak%
}%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% TCC renew requirement form (TCC register)%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@renewreqform}{%
	\@formtopbox{\@formstitle}{\@renewreqformtitle}%

	\vfill%
	\@tccdesc%

	\@formsstudentemaillabel : {\bf \@studentAemail} %

	\hfill \@formsadvisoremaillabel : {\bf \@studentA@advisoremail}%

	\hfill \@formsphonelabel : {\bf \@studentA@advisorphone}%
	\vfill%
	{\bf \@formsbrieflabel}:\footnote[1]{\@renewreqformnotes}%

	\@tccbrief%
	\vfill%
	\@formsigdate{\@studentsignature}%
	\vfill%

	\@formsigdate{\@advisorsignature}%
	\vfill%
	\pagebreak%
}%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% TCC Board approval form%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@examboardform}{%
	\@formtopbox{\@formstitle}{\@examboardformtitle}%

	\vfill%

	\@tccdesc%

	\vfill%
	\begin{center}
		\@formsboardtitle
	\end{center}%

	\@examinerdesc{studentA}{examinerA}%

	\@examinerdesc{studentA}{examinerB}%

	\@examinerdesc{studentA}{examinerC}%

	\@examinerdesc[\@formsaltexaminerlabel]{studentA}{altexaminerA}%

	\vfill%

	\@examboardformdesc%
	\vfill%

	\@formsigdate{\@advisorsignature}%
	\vfill%

	\pagebreak%
}%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% TCC Board reciepts form%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@recieptform}[1]{%
	\@formtopbox[@recieptformfootnote]{\@formstitle}{\@recieptformtitle}%

	\vfill%

	\@tccdesc%

	\@formsboardlabel : {\bf \csname @student\Alph{TCC@studentcount}@#1\endcsname }%

	\vfill%
	\@recieptformdesc {\bf \@studentA},\ \ \ \@formsstudentIDlabel : {\bf \@studentAID}.%

	\vfill%

	\@formsigdate{\@boardsignature}%
	\vfill%
	\pagebreak%
}%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% examiners approval/not signature (for rectify approval form)%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@approvalsigdate}[2]{%%
	\@formsrectifyOKdesc%
	\hfill\@formsdatelabel:\rule{\@daterule}{.1pt}\\[3mm]%
	#1: #2 \hfill  \@formssignaturelabel:\rule{\@namerule}{.1pt}%
}%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% TCC Board rectify approval form%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@rectifyexaminersig}[2][\@formsexaminerlabel]{\@ifundefined{#2}{}{\@approvalsigdate{#1}{\csname #2\endcsname}}\\[3mm]}%
\newcommand{\@rectifyapprovalform}{%
	\@formtopbox{\@formstitle}{\@rectifyapprovalformtitle}%

	\vfill%

	\@tccdesc%

	\vfill%
	\@rectifyapprovalformdesc%

	\vfill%

	\@rectifyexaminersig[\@formsadvisorlabel]{@studentA@advisor}%

	\vfill%

	\@ifundefined{@nBoard}{}{%
		\@rectifyexaminersig{@studentA@examinerA}%
	}%

	\@rectifyexaminersig{@studentA@examinerB}%

	\@rectifyexaminersig{@studentA@examinerC}%

	\@rectifyexaminersig{@studentA@altexaminerA}%
	\vfill%
	\pagebreak%
}%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% TCC Advisor approval form%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\@advisorapprovalform}{%
	\@formtopbox{\@formstitle}{\@advisorapprovalformtitle}%

	\vfill%

	\@tccdesc%

	\vfill%
	\@advisorapprovalformdesc%

	\vfill%

  \@tccadvisorsreview%

	\vfill%
	\@advisorapprovalformdescB%

	\@formsigdate{\@advisorsignature}%
	\vfill%

	\@formsigdate{\@studentsignature}%
	\vfill%
	\pagebreak%
}%
%
%
%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%
%
%%
% produz o Brasao do Servico Publico Federal; o parametro opcional e' um%
% fator de escala%
%%
% ex.:%
%       \spfshield           % tamanho normal (fonte equiv. a 10pt)%
%       \spfshield[2]        % com o dobro do tamanho%
%       \spfshield[.5]       % com metade do tamanho%
%%
\DeclareRobustCommand{\spfshield}[1][1]{%
        \includegraphics[scale=#1]{brasao_spf}%
}%
%
%%
% produz o Brasao da UFRGS; o parametro opcional e' um%
% fator de escala%
%%
% ex.:%
%       \ufrgsshield         % tamanho normal (fonte equiv. a 10pt)%
%       \ufrgsshield[2]      % com o dobro do tamanho%
%       \ufrgsshield[.5]     % com metade do tamanho%
%%
\DeclareRobustCommand{\ufrgsshield}[1][1]{%
        \includegraphics[scale=#1]{brasao_ufrgs}%
}%
%
%%
% produz o logo da UFRGS; o parametro opcional e' um%
% fator de escala%
%%
% ex.:%
%       \ufrgslogo         % tamanho normal (fonte equiv. a 10pt)%
%       \ufrgslogo[2]      % com o dobro do tamanho%
%       \ufrgslogo[.5]     % com metade do tamanho%
%%
\DeclareRobustCommand{\ufrgslogo}[1][1]{%
        \includegraphics[scale=#1]{logo_ufrgs}%
}%
%
%%
% produz o logotipo da Escola; o parametro opcional e' um%
% fator de escala%
%%
% ex.:%
%       \eelogo         % tamanho normal (fonte equiv. a 10pt)%
%       \eelogo[2]      % com o dobro do tamanho%
%       \eelogo[.5]     % com metade do tamanho%
%%
\DeclareRobustCommand{\eelogo}[1][1]{%
        \includegraphics[scale=#1]{brasao_ee}%
}%
%
%%
% produz o logotipo do PPGEE; o parametro opcional e' um%
% fator de escala%
%%
% ex.:%
%       \ppgeelogo         % tamanho normal (fonte equiv. a 10pt)%
%       \ppgeelogo[2]      % com o dobro do tamanho%
%       \ppgeelogo[.5]     % com metade do tamanho%
%%
\DeclareRobustCommand{\ppgeelogo}[1][1]{%
        \includegraphics[scale=#1]{ppgeelogo}%
}%
%
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% set of blank lines%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\@cdef{formsblanklines}{\hrulefill\\%

\hrulefill\\%

\hrulefill\\%

\hrulefill\\%

\hrulefill\\%

\hrulefill\\%

\hrulefill%
}%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% pre-define the title as a blank line%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\title{\hrulefill\\%
\rule{1pt}{.1pt}\hrulefill}%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% assure student/advisor/examiners... commands are defined with underlines (if not already defined)%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@IDrule{30mm}%
\def\@emailrule{40mm}%
\def\@namerule{50mm}%
\def\@titlerule{40mm}%
\def\@phonerule{20mm}%
\def\@agreerule{25mm}%
\def\@daterule{15mm}%
%%%
%%
%%%
\newcommand{\@emptyfields}{%
	\@ifundefined{@studentA}{%
		\student{\rule{\@namerule}{.1pt}}{}%
		\studentinfo{\rule{\@IDrule}{.1pt}}{\rule{\@emailrule}{.1pt}}%
		}{}%
	\@ifundefined{@studentA@advisor}{%
		\advisor{\rule{\@namerule}{.1pt}}{}%
		\advisorinfo{}{\rule{\@titlerule}{.1pt}}{\rule{\@emailrule}{.1pt}}{\rule{\@phonerule}{.1pt}}%
		}{}%
%
	\@ifundefined{@studentA@examinerC}{%
		\examiner{\rule{\@namerule}{.1pt}}{}%
		\examinerinfo{}{\rule{\@titlerule}{.1pt}}{\rule{\@emailrule}{.1pt}}{\rule{\@phonerule}{.1pt}}%
		}{}%
	\@ifundefined{@studentA@examinerC}{%
		\examiner{\rule{\@namerule}{.1pt}}{}%
		\examinerinfo{}{\rule{\@titlerule}{.1pt}}{\rule{\@emailrule}{.1pt}}{\rule{\@phonerule}{.1pt}}%
		}{}%
	\@ifundefined{@studentA@examinerC}{%
		\examiner{\rule{\@namerule}{.1pt}}{}%
		\examinerinfo{}{\rule{\@titlerule}{.1pt}}{\rule{\@emailrule}{.1pt}}{\rule{\@phonerule}{.1pt}}%
		}{}%
	\@ifundefined{@studentA@altexaminerA}{%
		\altexaminer{\rule{\@namerule}{.1pt}}{}%
		\altexaminerinfo{}{\rule{\@titlerule}{.1pt}}{\rule{\@emailrule}{.1pt}}{\rule{\@phonerule}{.1pt}}%
		}{}%
	\@ifundefined{@tccbrief}{%
		\tccbrief{\@formsblanklines}%
		}{}%
	\@ifundefined{@tcccoadvisorbrief}{%
		\tcccoadvisorbrief{\@formsblanklines}%
		}{}%
	\@ifundefined{@tccadvisorsreview}{%
		\tccadvisorsreview{\@formsblanklines}%
		}{}%
%
	\@ifundefined{@tcccalendareventdateh}{\tcccalendareventdate{---}}{}%
	\@ifundefined{@tcccalendareventdateh}{\tcccalendareventdate{---}}{}%
	\@ifundefined{@tcccalendareventdateh}{\tcccalendareventdate{---}}{}%
	\@ifundefined{@tcccalendareventdateh}{\tcccalendareventdate{---}}{}%
	\@ifundefined{@tcccalendareventdateh}{\tcccalendareventdate{---}}{}%
	\@ifundefined{@tcccalendareventdateh}{\tcccalendareventdate{---}}{}%
	\@ifundefined{@tcccalendareventdateh}{\tcccalendareventdate{---}}{}%
	\@ifundefined{@tcccalendareventdateh}{\tcccalendareventdate{---}}{}%
}%
%
%
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%

\newif\if@coord@emptyforms\@coord@emptyformsfalse
		\newif\if@coord@forms@reqform\@coord@forms@reqformtrue
		\newif\if@coord@forms@coadvisor\@coord@forms@coadvisortrue
		\newif\if@coord@forms@examboard\@coord@forms@examboardtrue
		\newif\if@coord@forms@advisorapproval\@coord@forms@advisorapprovaltrue
		\newif\if@coord@forms@reciept\@coord@forms@reciepttrue
		\newif\if@coord@forms@examiners\@coord@forms@examinerstrue
		\newif\if@coord@forms@rectifyapproval\@coord@forms@rectifyapprovaltrue
\newif\if@coord@calendar\@coord@calendarfalse
\newif\if@coord@checklist\@coord@checklistfalse
\newif\if@coord@report\@coord@reportfalse
\newif\if@coord@boards\@coord@boardsfalse
\newif\if@coord@boarddates\@coord@boarddatesfalse
\newif\if@coord@studentlist\@coord@studentlistfalse

\newif\if@coord@forms@revforms\@coord@forms@revformstrue
\newif\if@coord@forms@referral\@coord@forms@referraltrue



\newcommand{\@coordDoc}[1]{%%
	\@ifundefined{@coord}{%
%% Just in case @coord option wasn´t used.%
		\begin{document}%
			\if@coord@forms@reqform
				\reqform%
			\fi
			\if@coord@forms@coadvisor
				\coadvisorform
			\fi
			\if@coord@forms@examboard
				\examboardform%
			\fi
			\if@coord@forms@advisorapproval
				\advisorapprovalform%
			\fi
			\if@coord@forms@reciept
				\recieptforms%
			\fi
			\if@coord@forms@examiners
				\examinersforms%
			\fi
			\if@coord@forms@rectifyapproval
				\rectifyapprovalform%
			\fi
		\end{document}%
	}{%
%		\@ifundefined{@coord@emptyforms}{%
	\if@coord@emptyforms
			\@emptyfields%
			\begin{document}%
			\if@coord@forms@reqform
				\reqform%
			\fi
			\if@coord@forms@coadvisor
				\coadvisorform
			\fi
			\if@coord@forms@examboard
				\examboardform%
			\fi
			\if@coord@forms@advisorapproval
				\advisorapprovalform%
			\fi
			\@examiners{examinerA}%
			\if@coord@forms@reciept
				\@recieptform{examinerA}%
			\fi
			\if@coord@forms@examiners
				\@examinerforms{examinerA}%
			\fi
			\if@coord@forms@rectifyapproval
				\rectifyapprovalform%
			\fi
			

%				\reqform%
%				\examboardform%
%				\advisorapprovalform%
%				\@examiners{examinerA}%
%				\@recieptform{examinerA}%
%				\rectifyapprovalform%
			\end{document} %
%		}{%
	\else
				\begin{document}%
				\if@coord@calendar
					\@TCCcalendar
				\fi
%				\@ifundefined{@coord@calendar}{}{\@TCCcalendar}%
			#1%
				\if@coord@checklist
					\@TCCchecklist
				\fi
				%\@ifundefined{@coord@checklist}{}{\@TCCchecklist}%
				\if@coord@report
				  \@TCCreport
				\fi
				%\@ifundefined{@coord@report}{}{\@TCCreport}%
				\if@coord@boards
				  \@TCCboards
				\fi
				\if@coord@studentlist
				  \@studentlistform
				\fi
				
				%\@ifundefined{@coord@boards}{}{\@TCCboards}%
				%\@ifundefined{@coord@studentlist}{}{\@studentlistform}%
			\end{document}%

%		}%
	\fi
	
}%
}%
%
%
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%
\if@english%
 \input{TCC-en-spec.def}%
\else%
 \input{TCC-pt_BR-spec.def}%
\fi%
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% load local.tex BEFORE executing \@emptyfields, unless @coord case%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\@ifundefined{@coord}{%
	\IfFileExists{local.tex}{\input{local.tex}}{}%
	\@emptyfields%
}{}%
