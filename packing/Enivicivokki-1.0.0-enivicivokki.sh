#!/bin/sh

# Display usage
cpack_usage()
{
  cat <<EOF
Usage: $0 [options]
Options: [defaults in brackets after descriptions]
  --help            print this message
  --version         print cmake installer version
  --prefix=dir      directory in which to install
  --include-subdir  include the Enivicivokki-1.0.0-enivicivokki subdirectory
  --exclude-subdir  exclude the Enivicivokki-1.0.0-enivicivokki subdirectory
  --skip-license    accept license
EOF
  exit 1
}

cpack_echo_exit()
{
  echo $1
  exit 1
}

# Display version
cpack_version()
{
  echo "Enivicivokki Installer Version: 1.0.0, Copyright (c) Humanity"
}

# Helper function to fix windows paths.
cpack_fix_slashes ()
{
  echo "$1" | sed 's/\\/\//g'
}

interactive=TRUE
cpack_skip_license=FALSE
cpack_include_subdir=""
for a in "$@"; do
  if echo $a | grep "^--prefix=" > /dev/null 2> /dev/null; then
    cpack_prefix_dir=`echo $a | sed "s/^--prefix=//"`
    cpack_prefix_dir=`cpack_fix_slashes "${cpack_prefix_dir}"`
  fi
  if echo $a | grep "^--help" > /dev/null 2> /dev/null; then
    cpack_usage
  fi
  if echo $a | grep "^--version" > /dev/null 2> /dev/null; then
    cpack_version
    exit 2
  fi
  if echo $a | grep "^--include-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=TRUE
  fi
  if echo $a | grep "^--exclude-subdir" > /dev/null 2> /dev/null; then
    cpack_include_subdir=FALSE
  fi
  if echo $a | grep "^--skip-license" > /dev/null 2> /dev/null; then
    cpack_skip_license=TRUE
  fi
done

if [ "x${cpack_include_subdir}x" != "xx" -o "x${cpack_skip_license}x" = "xTRUEx" ]
then
  interactive=FALSE
fi

cpack_version
echo "This is a self-extracting archive."
toplevel="`pwd`"
if [ "x${cpack_prefix_dir}x" != "xx" ]
then
  toplevel="${cpack_prefix_dir}"
fi

echo "The archive will be extracted to: ${toplevel}"

if [ "x${interactive}x" = "xTRUEx" ]
then
  echo ""
  echo "If you want to stop extracting, please press <ctrl-C>."

  if [ "x${cpack_skip_license}x" != "xTRUEx" ]
  then
    more << '____cpack__here_doc____'
                    GNU GENERAL PUBLIC LICENSE
                       Version 3, 29 June 2007

 Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
 Everyone is permitted to copy and distribute verbatim copies
 of this license document, but changing it is not allowed.

                            Preamble

  The GNU General Public License is a free, copyleft license for
software and other kinds of works.

  The licenses for most software and other practical works are designed
to take away your freedom to share and change the works.  By contrast,
the GNU General Public License is intended to guarantee your freedom to
share and change all versions of a program--to make sure it remains free
software for all its users.  We, the Free Software Foundation, use the
GNU General Public License for most of our software; it applies also to
any other work released this way by its authors.  You can apply it to
your programs, too.

  When we speak of free software, we are referring to freedom, not
price.  Our General Public Licenses are designed to make sure that you
have the freedom to distribute copies of free software (and charge for
them if you wish), that you receive source code or can get it if you
want it, that you can change the software or use pieces of it in new
free programs, and that you know you can do these things.

  To protect your rights, we need to prevent others from denying you
these rights or asking you to surrender the rights.  Therefore, you have
certain responsibilities if you distribute copies of the software, or if
you modify it: responsibilities to respect the freedom of others.

  For example, if you distribute copies of such a program, whether
gratis or for a fee, you must pass on to the recipients the same
freedoms that you received.  You must make sure that they, too, receive
or can get the source code.  And you must show them these terms so they
know their rights.

  Developers that use the GNU GPL protect your rights with two steps:
(1) assert copyright on the software, and (2) offer you this License
giving you legal permission to copy, distribute and/or modify it.

  For the developers' and authors' protection, the GPL clearly explains
that there is no warranty for this free software.  For both users' and
authors' sake, the GPL requires that modified versions be marked as
changed, so that their problems will not be attributed erroneously to
authors of previous versions.

  Some devices are designed to deny users access to install or run
modified versions of the software inside them, although the manufacturer
can do so.  This is fundamentally incompatible with the aim of
protecting users' freedom to change the software.  The systematic
pattern of such abuse occurs in the area of products for individuals to
use, which is precisely where it is most unacceptable.  Therefore, we
have designed this version of the GPL to prohibit the practice for those
products.  If such problems arise substantially in other domains, we
stand ready to extend this provision to those domains in future versions
of the GPL, as needed to protect the freedom of users.

  Finally, every program is threatened constantly by software patents.
States should not allow patents to restrict development and use of
software on general-purpose computers, but in those that do, we wish to
avoid the special danger that patents applied to a free program could
make it effectively proprietary.  To prevent this, the GPL assures that
patents cannot be used to render the program non-free.

  The precise terms and conditions for copying, distribution and
modification follow.

                       TERMS AND CONDITIONS

  0. Definitions.

  "This License" refers to version 3 of the GNU General Public License.

  "Copyright" also means copyright-like laws that apply to other kinds of
works, such as semiconductor masks.

  "The Program" refers to any copyrightable work licensed under this
License.  Each licensee is addressed as "you".  "Licensees" and
"recipients" may be individuals or organizations.

  To "modify" a work means to copy from or adapt all or part of the work
in a fashion requiring copyright permission, other than the making of an
exact copy.  The resulting work is called a "modified version" of the
earlier work or a work "based on" the earlier work.

  A "covered work" means either the unmodified Program or a work based
on the Program.

  To "propagate" a work means to do anything with it that, without
permission, would make you directly or secondarily liable for
infringement under applicable copyright law, except executing it on a
computer or modifying a private copy.  Propagation includes copying,
distribution (with or without modification), making available to the
public, and in some countries other activities as well.

  To "convey" a work means any kind of propagation that enables other
parties to make or receive copies.  Mere interaction with a user through
a computer network, with no transfer of a copy, is not conveying.

  An interactive user interface displays "Appropriate Legal Notices"
to the extent that it includes a convenient and prominently visible
feature that (1) displays an appropriate copyright notice, and (2)
tells the user that there is no warranty for the work (except to the
extent that warranties are provided), that licensees may convey the
work under this License, and how to view a copy of this License.  If
the interface presents a list of user commands or options, such as a
menu, a prominent item in the list meets this criterion.

  1. Source Code.

  The "source code" for a work means the preferred form of the work
for making modifications to it.  "Object code" means any non-source
form of a work.

  A "Standard Interface" means an interface that either is an official
standard defined by a recognized standards body, or, in the case of
interfaces specified for a particular programming language, one that
is widely used among developers working in that language.

  The "System Libraries" of an executable work include anything, other
than the work as a whole, that (a) is included in the normal form of
packaging a Major Component, but which is not part of that Major
Component, and (b) serves only to enable use of the work with that
Major Component, or to implement a Standard Interface for which an
implementation is available to the public in source code form.  A
"Major Component", in this context, means a major essential component
(kernel, window system, and so on) of the specific operating system
(if any) on which the executable work runs, or a compiler used to
produce the work, or an object code interpreter used to run it.

  The "Corresponding Source" for a work in object code form means all
the source code needed to generate, install, and (for an executable
work) run the object code and to modify the work, including scripts to
control those activities.  However, it does not include the work's
System Libraries, or general-purpose tools or generally available free
programs which are used unmodified in performing those activities but
which are not part of the work.  For example, Corresponding Source
includes interface definition files associated with source files for
the work, and the source code for shared libraries and dynamically
linked subprograms that the work is specifically designed to require,
such as by intimate data communication or control flow between those
subprograms and other parts of the work.

  The Corresponding Source need not include anything that users
can regenerate automatically from other parts of the Corresponding
Source.

  The Corresponding Source for a work in source code form is that
same work.

  2. Basic Permissions.

  All rights granted under this License are granted for the term of
copyright on the Program, and are irrevocable provided the stated
conditions are met.  This License explicitly affirms your unlimited
permission to run the unmodified Program.  The output from running a
covered work is covered by this License only if the output, given its
content, constitutes a covered work.  This License acknowledges your
rights of fair use or other equivalent, as provided by copyright law.

  You may make, run and propagate covered works that you do not
convey, without conditions so long as your license otherwise remains
in force.  You may convey covered works to others for the sole purpose
of having them make modifications exclusively for you, or provide you
with facilities for running those works, provided that you comply with
the terms of this License in conveying all material for which you do
not control copyright.  Those thus making or running the covered works
for you must do so exclusively on your behalf, under your direction
and control, on terms that prohibit them from making any copies of
your copyrighted material outside their relationship with you.

  Conveying under any other circumstances is permitted solely under
the conditions stated below.  Sublicensing is not allowed; section 10
makes it unnecessary.

  3. Protecting Users' Legal Rights From Anti-Circumvention Law.

  No covered work shall be deemed part of an effective technological
measure under any applicable law fulfilling obligations under article
11 of the WIPO copyright treaty adopted on 20 December 1996, or
similar laws prohibiting or restricting circumvention of such
measures.

  When you convey a covered work, you waive any legal power to forbid
circumvention of technological measures to the extent such circumvention
is effected by exercising rights under this License with respect to
the covered work, and you disclaim any intention to limit operation or
modification of the work as a means of enforcing, against the work's
users, your or third parties' legal rights to forbid circumvention of
technological measures.

  4. Conveying Verbatim Copies.

  You may convey verbatim copies of the Program's source code as you
receive it, in any medium, provided that you conspicuously and
appropriately publish on each copy an appropriate copyright notice;
keep intact all notices stating that this License and any
non-permissive terms added in accord with section 7 apply to the code;
keep intact all notices of the absence of any warranty; and give all
recipients a copy of this License along with the Program.

  You may charge any price or no price for each copy that you convey,
and you may offer support or warranty protection for a fee.

  5. Conveying Modified Source Versions.

  You may convey a work based on the Program, or the modifications to
produce it from the Program, in the form of source code under the
terms of section 4, provided that you also meet all of these conditions:

    a) The work must carry prominent notices stating that you modified
    it, and giving a relevant date.

    b) The work must carry prominent notices stating that it is
    released under this License and any conditions added under section
    7.  This requirement modifies the requirement in section 4 to
    "keep intact all notices".

    c) You must license the entire work, as a whole, under this
    License to anyone who comes into possession of a copy.  This
    License will therefore apply, along with any applicable section 7
    additional terms, to the whole of the work, and all its parts,
    regardless of how they are packaged.  This License gives no
    permission to license the work in any other way, but it does not
    invalidate such permission if you have separately received it.

    d) If the work has interactive user interfaces, each must display
    Appropriate Legal Notices; however, if the Program has interactive
    interfaces that do not display Appropriate Legal Notices, your
    work need not make them do so.

  A compilation of a covered work with other separate and independent
works, which are not by their nature extensions of the covered work,
and which are not combined with it such as to form a larger program,
in or on a volume of a storage or distribution medium, is called an
"aggregate" if the compilation and its resulting copyright are not
used to limit the access or legal rights of the compilation's users
beyond what the individual works permit.  Inclusion of a covered work
in an aggregate does not cause this License to apply to the other
parts of the aggregate.

  6. Conveying Non-Source Forms.

  You may convey a covered work in object code form under the terms
of sections 4 and 5, provided that you also convey the
machine-readable Corresponding Source under the terms of this License,
in one of these ways:

    a) Convey the object code in, or embodied in, a physical product
    (including a physical distribution medium), accompanied by the
    Corresponding Source fixed on a durable physical medium
    customarily used for software interchange.

    b) Convey the object code in, or embodied in, a physical product
    (including a physical distribution medium), accompanied by a
    written offer, valid for at least three years and valid for as
    long as you offer spare parts or customer support for that product
    model, to give anyone who possesses the object code either (1) a
    copy of the Corresponding Source for all the software in the
    product that is covered by this License, on a durable physical
    medium customarily used for software interchange, for a price no
    more than your reasonable cost of physically performing this
    conveying of source, or (2) access to copy the
    Corresponding Source from a network server at no charge.

    c) Convey individual copies of the object code with a copy of the
    written offer to provide the Corresponding Source.  This
    alternative is allowed only occasionally and noncommercially, and
    only if you received the object code with such an offer, in accord
    with subsection 6b.

    d) Convey the object code by offering access from a designated
    place (gratis or for a charge), and offer equivalent access to the
    Corresponding Source in the same way through the same place at no
    further charge.  You need not require recipients to copy the
    Corresponding Source along with the object code.  If the place to
    copy the object code is a network server, the Corresponding Source
    may be on a different server (operated by you or a third party)
    that supports equivalent copying facilities, provided you maintain
    clear directions next to the object code saying where to find the
    Corresponding Source.  Regardless of what server hosts the
    Corresponding Source, you remain obligated to ensure that it is
    available for as long as needed to satisfy these requirements.

    e) Convey the object code using peer-to-peer transmission, provided
    you inform other peers where the object code and Corresponding
    Source of the work are being offered to the general public at no
    charge under subsection 6d.

  A separable portion of the object code, whose source code is excluded
from the Corresponding Source as a System Library, need not be
included in conveying the object code work.

  A "User Product" is either (1) a "consumer product", which means any
tangible personal property which is normally used for personal, family,
or household purposes, or (2) anything designed or sold for incorporation
into a dwelling.  In determining whether a product is a consumer product,
doubtful cases shall be resolved in favor of coverage.  For a particular
product received by a particular user, "normally used" refers to a
typical or common use of that class of product, regardless of the status
of the particular user or of the way in which the particular user
actually uses, or expects or is expected to use, the product.  A product
is a consumer product regardless of whether the product has substantial
commercial, industrial or non-consumer uses, unless such uses represent
the only significant mode of use of the product.

  "Installation Information" for a User Product means any methods,
procedures, authorization keys, or other information required to install
and execute modified versions of a covered work in that User Product from
a modified version of its Corresponding Source.  The information must
suffice to ensure that the continued functioning of the modified object
code is in no case prevented or interfered with solely because
modification has been made.

  If you convey an object code work under this section in, or with, or
specifically for use in, a User Product, and the conveying occurs as
part of a transaction in which the right of possession and use of the
User Product is transferred to the recipient in perpetuity or for a
fixed term (regardless of how the transaction is characterized), the
Corresponding Source conveyed under this section must be accompanied
by the Installation Information.  But this requirement does not apply
if neither you nor any third party retains the ability to install
modified object code on the User Product (for example, the work has
been installed in ROM).

  The requirement to provide Installation Information does not include a
requirement to continue to provide support service, warranty, or updates
for a work that has been modified or installed by the recipient, or for
the User Product in which it has been modified or installed.  Access to a
network may be denied when the modification itself materially and
adversely affects the operation of the network or violates the rules and
protocols for communication across the network.

  Corresponding Source conveyed, and Installation Information provided,
in accord with this section must be in a format that is publicly
documented (and with an implementation available to the public in
source code form), and must require no special password or key for
unpacking, reading or copying.

  7. Additional Terms.

  "Additional permissions" are terms that supplement the terms of this
License by making exceptions from one or more of its conditions.
Additional permissions that are applicable to the entire Program shall
be treated as though they were included in this License, to the extent
that they are valid under applicable law.  If additional permissions
apply only to part of the Program, that part may be used separately
under those permissions, but the entire Program remains governed by
this License without regard to the additional permissions.

  When you convey a copy of a covered work, you may at your option
remove any additional permissions from that copy, or from any part of
it.  (Additional permissions may be written to require their own
removal in certain cases when you modify the work.)  You may place
additional permissions on material, added by you to a covered work,
for which you have or can give appropriate copyright permission.

  Notwithstanding any other provision of this License, for material you
add to a covered work, you may (if authorized by the copyright holders of
that material) supplement the terms of this License with terms:

    a) Disclaiming warranty or limiting liability differently from the
    terms of sections 15 and 16 of this License; or

    b) Requiring preservation of specified reasonable legal notices or
    author attributions in that material or in the Appropriate Legal
    Notices displayed by works containing it; or

    c) Prohibiting misrepresentation of the origin of that material, or
    requiring that modified versions of such material be marked in
    reasonable ways as different from the original version; or

    d) Limiting the use for publicity purposes of names of licensors or
    authors of the material; or

    e) Declining to grant rights under trademark law for use of some
    trade names, trademarks, or service marks; or

    f) Requiring indemnification of licensors and authors of that
    material by anyone who conveys the material (or modified versions of
    it) with contractual assumptions of liability to the recipient, for
    any liability that these contractual assumptions directly impose on
    those licensors and authors.

  All other non-permissive additional terms are considered "further
restrictions" within the meaning of section 10.  If the Program as you
received it, or any part of it, contains a notice stating that it is
governed by this License along with a term that is a further
restriction, you may remove that term.  If a license document contains
a further restriction but permits relicensing or conveying under this
License, you may add to a covered work material governed by the terms
of that license document, provided that the further restriction does
not survive such relicensing or conveying.

  If you add terms to a covered work in accord with this section, you
must place, in the relevant source files, a statement of the
additional terms that apply to those files, or a notice indicating
where to find the applicable terms.

  Additional terms, permissive or non-permissive, may be stated in the
form of a separately written license, or stated as exceptions;
the above requirements apply either way.

  8. Termination.

  You may not propagate or modify a covered work except as expressly
provided under this License.  Any attempt otherwise to propagate or
modify it is void, and will automatically terminate your rights under
this License (including any patent licenses granted under the third
paragraph of section 11).

  However, if you cease all violation of this License, then your
license from a particular copyright holder is reinstated (a)
provisionally, unless and until the copyright holder explicitly and
finally terminates your license, and (b) permanently, if the copyright
holder fails to notify you of the violation by some reasonable means
prior to 60 days after the cessation.

  Moreover, your license from a particular copyright holder is
reinstated permanently if the copyright holder notifies you of the
violation by some reasonable means, this is the first time you have
received notice of violation of this License (for any work) from that
copyright holder, and you cure the violation prior to 30 days after
your receipt of the notice.

  Termination of your rights under this section does not terminate the
licenses of parties who have received copies or rights from you under
this License.  If your rights have been terminated and not permanently
reinstated, you do not qualify to receive new licenses for the same
material under section 10.

  9. Acceptance Not Required for Having Copies.

  You are not required to accept this License in order to receive or
run a copy of the Program.  Ancillary propagation of a covered work
occurring solely as a consequence of using peer-to-peer transmission
to receive a copy likewise does not require acceptance.  However,
nothing other than this License grants you permission to propagate or
modify any covered work.  These actions infringe copyright if you do
not accept this License.  Therefore, by modifying or propagating a
covered work, you indicate your acceptance of this License to do so.

  10. Automatic Licensing of Downstream Recipients.

  Each time you convey a covered work, the recipient automatically
receives a license from the original licensors, to run, modify and
propagate that work, subject to this License.  You are not responsible
for enforcing compliance by third parties with this License.

  An "entity transaction" is a transaction transferring control of an
organization, or substantially all assets of one, or subdividing an
organization, or merging organizations.  If propagation of a covered
work results from an entity transaction, each party to that
transaction who receives a copy of the work also receives whatever
licenses to the work the party's predecessor in interest had or could
give under the previous paragraph, plus a right to possession of the
Corresponding Source of the work from the predecessor in interest, if
the predecessor has it or can get it with reasonable efforts.

  You may not impose any further restrictions on the exercise of the
rights granted or affirmed under this License.  For example, you may
not impose a license fee, royalty, or other charge for exercise of
rights granted under this License, and you may not initiate litigation
(including a cross-claim or counterclaim in a lawsuit) alleging that
any patent claim is infringed by making, using, selling, offering for
sale, or importing the Program or any portion of it.

  11. Patents.

  A "contributor" is a copyright holder who authorizes use under this
License of the Program or a work on which the Program is based.  The
work thus licensed is called the contributor's "contributor version".

  A contributor's "essential patent claims" are all patent claims
owned or controlled by the contributor, whether already acquired or
hereafter acquired, that would be infringed by some manner, permitted
by this License, of making, using, or selling its contributor version,
but do not include claims that would be infringed only as a
consequence of further modification of the contributor version.  For
purposes of this definition, "control" includes the right to grant
patent sublicenses in a manner consistent with the requirements of
this License.

  Each contributor grants you a non-exclusive, worldwide, royalty-free
patent license under the contributor's essential patent claims, to
make, use, sell, offer for sale, import and otherwise run, modify and
propagate the contents of its contributor version.

  In the following three paragraphs, a "patent license" is any express
agreement or commitment, however denominated, not to enforce a patent
(such as an express permission to practice a patent or covenant not to
sue for patent infringement).  To "grant" such a patent license to a
party means to make such an agreement or commitment not to enforce a
patent against the party.

  If you convey a covered work, knowingly relying on a patent license,
and the Corresponding Source of the work is not available for anyone
to copy, free of charge and under the terms of this License, through a
publicly available network server or other readily accessible means,
then you must either (1) cause the Corresponding Source to be so
available, or (2) arrange to deprive yourself of the benefit of the
patent license for this particular work, or (3) arrange, in a manner
consistent with the requirements of this License, to extend the patent
license to downstream recipients.  "Knowingly relying" means you have
actual knowledge that, but for the patent license, your conveying the
covered work in a country, or your recipient's use of the covered work
in a country, would infringe one or more identifiable patents in that
country that you have reason to believe are valid.

  If, pursuant to or in connection with a single transaction or
arrangement, you convey, or propagate by procuring conveyance of, a
covered work, and grant a patent license to some of the parties
receiving the covered work authorizing them to use, propagate, modify
or convey a specific copy of the covered work, then the patent license
you grant is automatically extended to all recipients of the covered
work and works based on it.

  A patent license is "discriminatory" if it does not include within
the scope of its coverage, prohibits the exercise of, or is
conditioned on the non-exercise of one or more of the rights that are
specifically granted under this License.  You may not convey a covered
work if you are a party to an arrangement with a third party that is
in the business of distributing software, under which you make payment
to the third party based on the extent of your activity of conveying
the work, and under which the third party grants, to any of the
parties who would receive the covered work from you, a discriminatory
patent license (a) in connection with copies of the covered work
conveyed by you (or copies made from those copies), or (b) primarily
for and in connection with specific products or compilations that
contain the covered work, unless you entered into that arrangement,
or that patent license was granted, prior to 28 March 2007.

  Nothing in this License shall be construed as excluding or limiting
any implied license or other defenses to infringement that may
otherwise be available to you under applicable patent law.

  12. No Surrender of Others' Freedom.

  If conditions are imposed on you (whether by court order, agreement or
otherwise) that contradict the conditions of this License, they do not
excuse you from the conditions of this License.  If you cannot convey a
covered work so as to satisfy simultaneously your obligations under this
License and any other pertinent obligations, then as a consequence you may
not convey it at all.  For example, if you agree to terms that obligate you
to collect a royalty for further conveying from those to whom you convey
the Program, the only way you could satisfy both those terms and this
License would be to refrain entirely from conveying the Program.

  13. Use with the GNU Affero General Public License.

  Notwithstanding any other provision of this License, you have
permission to link or combine any covered work with a work licensed
under version 3 of the GNU Affero General Public License into a single
combined work, and to convey the resulting work.  The terms of this
License will continue to apply to the part which is the covered work,
but the special requirements of the GNU Affero General Public License,
section 13, concerning interaction through a network will apply to the
combination as such.

  14. Revised Versions of this License.

  The Free Software Foundation may publish revised and/or new versions of
the GNU General Public License from time to time.  Such new versions will
be similar in spirit to the present version, but may differ in detail to
address new problems or concerns.

  Each version is given a distinguishing version number.  If the
Program specifies that a certain numbered version of the GNU General
Public License "or any later version" applies to it, you have the
option of following the terms and conditions either of that numbered
version or of any later version published by the Free Software
Foundation.  If the Program does not specify a version number of the
GNU General Public License, you may choose any version ever published
by the Free Software Foundation.

  If the Program specifies that a proxy can decide which future
versions of the GNU General Public License can be used, that proxy's
public statement of acceptance of a version permanently authorizes you
to choose that version for the Program.

  Later license versions may give you additional or different
permissions.  However, no additional obligations are imposed on any
author or copyright holder as a result of your choosing to follow a
later version.

  15. Disclaimer of Warranty.

  THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY
APPLICABLE LAW.  EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT
HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY
OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM
IS WITH YOU.  SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF
ALL NECESSARY SERVICING, REPAIR OR CORRECTION.

  16. Limitation of Liability.

  IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MODIFIES AND/OR CONVEYS
THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY
GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE
USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF
DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD
PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS),
EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

  17. Interpretation of Sections 15 and 16.

  If the disclaimer of warranty and limitation of liability provided
above cannot be given local legal effect according to their terms,
reviewing courts shall apply local law that most closely approximates
an absolute waiver of all civil liability in connection with the
Program, unless a warranty or assumption of liability accompanies a
copy of the Program in return for a fee.

                     END OF TERMS AND CONDITIONS

            How to Apply These Terms to Your New Programs

  If you develop a new program, and you want it to be of the greatest
possible use to the public, the best way to achieve this is to make it
free software which everyone can redistribute and change under these terms.

  To do so, attach the following notices to the program.  It is safest
to attach them to the start of each source file to most effectively
state the exclusion of warranty; and each file should have at least
the "copyright" line and a pointer to where the full notice is found.

    <one line to give the program's name and a brief idea of what it does.>
    Copyright (C) <year>  <name of author>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

Also add information on how to contact you by electronic and paper mail.

  If the program does terminal interaction, make it output a short
notice like this when it starts in an interactive mode:

    <program>  Copyright (C) <year>  <name of author>
    This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
    This is free software, and you are welcome to redistribute it
    under certain conditions; type `show c' for details.

The hypothetical commands `show w' and `show c' should show the appropriate
parts of the General Public License.  Of course, your program's commands
might be different; for a GUI interface, you would use an "about box".

  You should also get your employer (if you work as a programmer) or school,
if any, to sign a "copyright disclaimer" for the program, if necessary.
For more information on this, and how to apply and follow the GNU GPL, see
<https://www.gnu.org/licenses/>.

  The GNU General Public License does not permit incorporating your program
into proprietary programs.  If your program is a subroutine library, you
may consider it more useful to permit linking proprietary applications with
the library.  If this is what you want to do, use the GNU Lesser General
Public License instead of this License.  But first, please read
<https://www.gnu.org/licenses/why-not-lgpl.html>.

____cpack__here_doc____
    echo
    while true
      do
        echo "Do you accept the license? [yn]: "
        read line leftover
        case ${line} in
          y* | Y*)
            cpack_license_accepted=TRUE
            break;;
          n* | N* | q* | Q* | e* | E*)
            echo "License not accepted. Exiting ..."
            exit 1;;
        esac
      done
  fi

  if [ "x${cpack_include_subdir}x" = "xx" ]
  then
    echo "By default the Enivicivokki will be installed in:"
    echo "  \"${toplevel}/Enivicivokki-1.0.0-enivicivokki\""
    echo "Do you want to include the subdirectory Enivicivokki-1.0.0-enivicivokki?"
    echo "Saying no will install in: \"${toplevel}\" [Yn]: "
    read line leftover
    cpack_include_subdir=TRUE
    case ${line} in
      n* | N*)
        cpack_include_subdir=FALSE
    esac
  fi
fi

if [ "x${cpack_include_subdir}x" = "xTRUEx" ]
then
  toplevel="${toplevel}/Enivicivokki-1.0.0-enivicivokki"
  mkdir -p "${toplevel}"
fi
echo
echo "Using target directory: ${toplevel}"
echo "Extracting, please wait..."
echo ""

# take the archive portion of this file and pipe it to tar
# the NUMERIC parameter in this command should be one more
# than the number of lines in this header file
# there are tails which don't understand the "-n" argument, e.g. on SunOS
# OTOH there are tails which complain when not using the "-n" argument (e.g. GNU)
# so at first try to tail some file to see if tail fails if used with "-n"
# if so, don't use "-n"
use_new_tail_syntax="-n"
tail $use_new_tail_syntax +1 "$0" > /dev/null 2> /dev/null || use_new_tail_syntax=""

extractor="pax -r"
command -v pax > /dev/null 2> /dev/null || extractor="tar xf -"

tail $use_new_tail_syntax +824 "$0" | gunzip | (cd "${toplevel}" && ${extractor}) || cpack_echo_exit "Problem unpacking the Enivicivokki-1.0.0-enivicivokki"

echo "Unpacking finished successfully"

exit 0
#-----------------------------------------------------------
#      Start of TAR.GZ file
#-----------------------------------------------------------;
? ?~'b ?}	t?u???H e?Q?D#??A?J?eC???"Q?E???(C	h,2??--J)!X.???b?T????i~O?????R??I????<?J??>C??aYmxb???????nN?=?????????o`?6p??`????D??)?U?R?@??V???5?u??^??`Gb??vC,u??o??????y?@??+`??#?M??_
????C???7????o?mhh??]???pF????W???R?#?pU????c????p9?????????=?g???l????????????)0??]?,[????hFLo?k%?w??]?m??f?????"y?=u/??????+???;?????l??Y????n???v{??r????Wt???,ZcO???D??`{???a?bYt6?m??P0???????=Km,?_,??????A_(?=?7?E?/???????{7?[v?j?????a#?T??BYa???*???]??K?_J?N?W?Won??:?r?%Gw??rW4???X??W_??????????c??)?.????c??];??????v??e????;?s??e? ?? ???g????>K??(???#?&?
H7!m??>K
?c?5?r?/D?~%\?b?????m??p????1?????????_???????????c	x%T?4m?Q?Qf?`????v?|??\+???q?[M???K_Zk_N?????ly??X/?|8?v??2S!????:J?}5?q?r???8p???8p???8p???8?&A?3??????Q?L?{???X??g?`>????Ll?/?HJ96????Q????oAHy?????"??4o
??????c$?V?)%.????u?e??c??????7???~?????2?~F\l?GM?=??x??$)???????iP?d???p????5?e???'>G?
??{????. *?(G*?????@a=Vx?*P??7???0??oH1?-/??? R????????8??8??7??&??'!}??;?z?????l?Z?????':Y?A?&IS??Z?????&? ?S????c??;'x%??-?????p-^1/E>?Md??Rg??8???r????H)?pJ1?????E$r?Uk[?U??R?*'>?\?rj????$?fZ+?5?MC;M(???s'???????E?u\z??`>???9?!aA????F?q???>JY????F1	ip? ??i?|?
1-#?l\?2?????p???#???!???????9??Ie?H}<MJ??????-?;s\::C[??c?U ??????????L?i(qj2????u?&?M?)p?+?YM??
??????b]i????q?h???????R:?X?>~w??W2?`?B??O??W??????+U]V(??-dX(ap???GC?*5.2??b?8?[0?0?1??x?????58?[&?z;??x?t????B?c2?7=5B?C???P???H?b?????????k?4b~?f:???"9D?`T????O?2?"??u??42-??_a??A???T9????	j#????K?2???>?????W9??$H????P???4R^????K?????^p`?|?>??R??a?e?G2.=??Vn5????Y??T??x??1-W{x???k???y[e???	[?V??}?
??c!???"p????0?T??#??)????xK8LZ?~>c???oYt5Kbg??d??;X??E???"<`Y??k??$?m????#?'?|??????Q?,????z??eE*?U;?oR???gd?G??p,?*8f?7?EmC?@H??4???%[?\???>P ??PA?b?%??!????????}	??:?$?tBR?U?}?l?=?06O?L*+hM??????n???y?C???^F???'q??9)?????G?s?!CQ?Pg?Zj???X?/??T??H???9?g???????????mVZ?t?/b??<HfI?Z???,wZ??	?? ????????F??i????-??wX??l?m????F??t]}?x??=t??Z??7???=?r????:??5&n?????????)??????O??i?un??s?/C?????????f??_?-????c"];?x?O/????/?c?{?Qu??(?Lx?6J'??]~&??"?&?:????????#Qw????>S??##?????F@???g????????cbL??%????Yo?pPQ????X]????????u?'?f??Ru?I???$e??????<?????So"zfI????t???s??|??Tk)T???L=%6}???-8U?6biQ.?????^?b??Y???z#???U?P?????4}?I)??????Vfx??*Q?D?P????LH?F??tq?+e?$?NM??`???_??/????q??V?n??Rq???7???@q?? _?s??E|????????????????a=?S?c=??X??4f??A?k:????;]??r??f?w??#? ? ?w?{????~??????????;??K?G??(??????8??A?O?{???M?O??w????<q?????<??8?';n???]X6??h?N?k?~?S???p??[???p?y?????p?'85?S??S????8?N=?SGp?<N????? N}?<8u?????TN??????{q
Wd??>?y???rF?B??B?q#zGx??y9s?.??B??a?i?????????=c?9?c??F?-?mY?j[????Lo?s??T[??&? ??*?J?V??m??|?!o8?E??D\??{D$c?m?0r?"?P?y4?
{?p(}??;???1?zD????$D"????-???X?lv??GCb?o???????S?&????????w??;??}\L>??A???I?????i?>:,3?/???55NU#?x??0}k??P?????B+???M-??g$$a?/B??!2X`W?[??q????? ?{??????0p3?	??W??8p???8p???8p???8p???8p???8p???8p???8p??a?!??????po??571??{2?????`?;0?? ?0?y??c??~??'??????j??8p???8p???8p???8p???8p???8p???8p???8p???Uw???~??!??j???????E%?`%?r????]??n????P?	????n????????zX>dC?E???G?Dcmr??????e?nww??r4??G#`?n?>*??Q???~?`dI??|?7???B"?o?=?!5?pk??ke?+???????????7??z?j??f ????6W???C?h?????W?k?%??An??\+w?^gv!???'pm?P??m)?~?V?{??z?92 $i?F?"0?|:B????:???????@??
x7?"^??r{?? ?L:?-???PD??????((??@[v ???k??????) o?+?????V?2D???;??\?&;?????n???:5??=???j ?$?G??+???H-{????G??h??????F?FZ????Wo!?<X???T?X?W??T?h?#???U????&j??l8?Mj????*??B?????._?P0???N{???cT?dn?:w??
K?`?3T?9???N???A?/??]r?????sw?e8^\???"?x?6?	?)@?Q12??????d?????^w,??;?.<;?z? jD?]??h[}??????MP?5?Ei??	??7h?2?5?????=?X?l????"???a?J?[?>??}???????Gp??v?b?-e??"??%?,????j?????dm?E?4?@%?JD?????rd~?r1B?b,??1]?Y?M?~?:F?????h??|1Z?=?bt????????i%??????@?A?O?t?'y?BG???o1hi???3?S}?QK??????????ute???-??q???????6k??t??bm??u?	?2??U???
\???.3\????Z??A4V??9????y?J???????/?u3\8?n????~J??p[?9w?W?g??;???-??NQ?g???????uw8???y?^?^??w????????5???i?7?@:???|G???k?????????????>v???Yg????g???z{m]m5?????<?u?????4????Sl?????h?????j??D??????u7?)b??+?x;??E?????W??G?????R????
<??
???k;??h????_?L???????h?/
?ox??['F;???ty,??????f1?3f?(???
??!R~??????L?!X^???%7n???=?}???@?veB????H(vc=^1;1?[?%?q??????L?X?Y??gP??+??@,?&}?C??\??VgW????????Z>?????x??B??rO(??????*Fu???Y;???@??vC?~?~?W?P???????K;???????MMu????km|??4`??????????mb??a?????b??9?m?})??j?dk?,?m???Uz@l??g???u2??<???1?;_b?Y???_`xZ ? ?G|??????????~(??E?=????c???O??1?<P????????~N?~> A?o?3H?p?e?+??OCH?????????I=?K/k???kCj???????!????????3???H??Y??????0?y?Z??]%LN?ztG3z??W??w??he??%y;?D????? 	????????f?<^?"]????v??n??F??Mo???0?????C?.?O????2?w?_2k????^???]??g?????|??{?)?`?]???&e??!???Non???(^_J??????H??!???H??]?jJ?+T?????'?C|-???41?U??????|?j?????????JJ??:?3?|?
P8wz?M .?-R
???t+??\,7??!??Z
???????3?	??7U??XZ?K??????????Y???z#?????'??@M?6??Q??????)i^?l???.??q???WfffXIP+??v???x?????(i_??????L;???3Rqip
0????????????L??s??WT}KF?gz?%\??W?K??Omg???p(Nat?\u?eN7??mbm+????O????.5?????'z&??QU?????/?????g?1?S['JCjQ??g??V?l?qp?????A???X??e???KS???g?q ??"-'|d??nv&?C?y?A2??iR????l?????i??jc~????Kk?8??P??d?????M???????&?S????8?6?^?Z??H?"?O?M?`?V????;??+?n??$~B??
?6o|=?m	q??>m|?cB,?????#???????c 	]???e?7?3.??K??}=)d>? ?y?S#$:?	?	??z?4o?=ixC????????Z??!?C4F?!?"?+?P? 2?Y??DF?e??(??.??)???MP??g?_"???y??<??Ig?G]???H????P?i??
eb??????????p`T??s?????H??'p??O??X??d?Q?????t7?3}M?v2o?L^I???????Z???5?\:??????_Px*+?2??|??-?0i?[Q???? ????`R(?1z???????bY??k??$?N????#?'??l?}????u??'?????]?S;?oR?#y???	q?V??f??EmC?@H??4???"[?\???>P ???Z\??u??M??G]??%tu?I8???d???????{&?'`l?h?Tg?	???|???=4???;??$n?9'? ????9???????s?????xIF?r?G*S?n~???WcO_???YS??_??_?Y????i???????I??7??O??g??g?H8,T k???c?x???(?s????????I?????)]c?&?P???????\???$?NH?l??s?/C?????????f??_?-??3??k?F?q<????c?L??F?????(???nt???K?xJ???'?"?h??????LoTj?p?i}z?;?>&Vh?X?z????~R????]X????????w???!?mc?Y#z??????w??[?????63#T?g???????=g???fN-?V??????D+Z)z???m?a)?s???H???6???PDug?K@?a???7??;???X??<????7???9z??o????????S*?????z?g????`??<?V?o????????_??oc??Ey?M??&?w? ????$??????(??????_??O2??<??/??'?>eN??_????7?a????]??;??????i??9?2????????y??C?9?? ??g8????l????o??8_?????jb??<?V?8????????G_dr????????W?a	????n?`?,5%*??????E?????o?,P??b9??o?/???(?~&????( ?\N&???>?????m????}Lnq?J?c?%*wW?Z??frU???e???????????An??-+ ?? 7?????F???rw2?
????+h?(?M0????&???r?@????R??A???????l'?[X@?^??1??r?[???q??1?_!?????*???.?]???L?. ???][@noQ????~;???r???W?]^??W???AN?4????3?W????+??@q?????3?-4?T??oE?? ????, W	D???Z ????y?ngX?F?N??????cQ??5???B???72?3?:{X?3?e??42?/?OU?)[????_?y?F??U?&??#??Lb5U????W???6?K?l??6?M??g?O*???x9??\X? ?`}??h9Y?????=???r???ZN?`?e??????e??2r??*#mo=VF?4??edob]VF>#?N???\??&?^?u?D?????7???u??|g?7?=???R???l)?Y?+%g?J??w???????|?i?????~?j?1?_????[d?)????b???u???q??I???,??|???"???>[D?7?-???xb?????sFj??p7??0??}?F?w??????5????o ?a}?@??????{?K?sF????.??^??A ???~p=????0??o?W'?????4?????7??\D?????????X??Y? ????????+?p?????V??Y??a??%????-x???'?{m%#0??pw??*?z?,????0bx???1<?p/??;FO?>??2????a?a?????`???V?????J??/~???;??=?>???L????2?`Xd1|???7?B?/2?/??Di?<0m???|??W?XJ??v?>????3?????y? ,h???G??z?????h????y?????????W??0??s??f?????L^=?<??????e?S???\?????+???????y??JV_F????_`????wY}???)F???	?>?y??????+?V????B???????<?"?????T?????z>???S=??`|?|??Z_F???I=?0}?\yK)~??t	{_????????Q???a>??R???[?b?W???e?V???e????_?P}??KI??p?l???g????N~y??~???O??L??~?HK?????
-???g????w???DK:??u?????B-????\??]??o?}P{?>O??x=r???~?????PH??\'Ku>8??U]=?,??v^w?;?6ig????^]??w?|W{DW?k*????#G:B?????W??p5<?&?S??P?=???,4S?/????@?F}???^????7f??????_>?????*+?Q????jr~?4???>??????Y?z??kx'?}?m>Z?????4???R?m?zY??`???
?~???m?f?z???s?w????q?????=_{]?[=??2n?7?9__??17/??f=o=??(,*??c$??|???^??????????????g??0&???]k?:??}?_???X??{?G?7?e?=Og+???????	v?a??.?o??? ?M{???e???,?s?????4Wk
?e????d??3C`??Q?A??-???`<^?+???&G]?R?fh??{??????'???d?/c??j???Kx??B?R????l??????P?1W????H;?X?v?y??7L?QA????XM??6??)?8???????_?+7s?N??????<?`k??b?s??q?6??ln??%?????aVNM?????9?<?v?????%?b  