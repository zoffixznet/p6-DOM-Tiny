#!/usr/bin/env perl6
use v6;

use Test;
use DOM::Tiny;

# More real world JavaScript
my $dom = DOM::Tiny.parse(q:to/EOF/);
<!DOCTYPE html>
<html>
  <head>
    <title>Foo</title>
    <script src="/js/one.js"></script>
    <script src="/js/two.js"></script>
    <script src="/js/three.js"></script>
  </head>
  <body>Bar</body>
</html>
EOF
is $dom.at('title').text, 'Foo', 'right text';
is $dom.find('html > head > script').[0].attr('src'), '/js/one.js',
  'right attribute';
is $dom.find('html > head > script').[1].attr('src'), '/js/two.js',
  'right attribute';
is $dom.find('html > head > script').[2].attr('src'), '/js/three.js',
  'right attribute';
is $dom.find('html > head > script').[2].text, '', 'no text';
is $dom.at('html > body').text, 'Bar', 'right text';

done-testing;
